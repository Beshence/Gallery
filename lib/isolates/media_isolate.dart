import 'dart:isolate';

import 'package:photo_manager/photo_manager.dart';

import '../boxes/media_box.dart';
import '../misc.dart';


class MediaIsolate extends IsolateHandler {
  @override
  void main(ReceivePort mainReceivePort, SendPort isolateSendPort) {
    isolateSendPort.send("ping");
    mainReceivePort.listen((message) {
      List<String> args = message.split(".");
      var command = args.removeAt(0);
      switch(command) {
        case "pong":
          print("pong!");
          isolateSendPort.send("collect");
          break;
        case "collect":
          print("Isolate sent ${int.parse(args[0])}.");
          timelineChangeNotifier.updateTimeline();
          break;
        case "partial_collect":
          //print(message);
          timelineChangeNotifier.updateTimeline();
          break;
      }
    });
  }

  @override
  Future<void> isolate(ReceivePort isolateReceivePort, SendPort mainSendPort) async {
    MediaBox mediaBox = await MediaBox.create();
    isolateReceivePort.listen((message) async {
      List<String> args = message.split(".");
      var command = args.removeAt(0);
      switch(command) {
        case "ping":
          print("ping...");
          mainSendPort.send("pong");
          break;
        case "collect":
          mainSendPort.send("collect.${await collectLocalMedia(mainSendPort, mediaBox)}");
          break;
      }
    });
  }
}

Future<int> collectLocalMedia(SendPort mainSendPort, MediaBox mediaBox) async {
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  if (!ps.hasAccess) {
    return 0;
  }
  final List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(hasAll: false);
  if (folders.isEmpty) {
    return 0;
  }

  await mediaBox.dropLocalFolders();
  //await mediaBox.dropLocalMedia();

  for(AssetPathEntity folder in folders) {
    // first of all, we ensure that this folder is in database.
    await mediaBox.addLocalFolder(LocalFolder(id: folder.id, name: folder.name));

    // then we get all items of this folder from the database.
    // we need this to get the list of deleted assets
    Map<String, LocalMedia> knownDbAssets = await mediaBox.getAllAssetsOfLocalFolder(folder.id);

    // then we manipulate this list.
    int totalAssetsCount = await folder.assetCountAsync;
    int currentAssetsCount = 0;

    while(currentAssetsCount < totalAssetsCount) {
      // we get the portion of assets.
      final List<AssetEntity> rawAssets = await folder.getAssetListRange(
          start: currentAssetsCount,
          end: currentAssetsCount + 100
      );
      currentAssetsCount+=rawAssets.length;

      // and we create lists to work with.
      List<AssetEntity> newAssets = [];
      List<AssetEntity> modifiedAssets = [];

      for(AssetEntity asset in rawAssets) {
        // check if everything is okay with this asset:
        // more specifically, this asset was not changed.

        // 1. check if asset is present in the db.
        LocalMedia? knownDbAsset = knownDbAssets.remove(asset.id);

        if (knownDbAsset == null) {
          newAssets.add(asset);
          continue;
        }

        // 2. check if asset was not modified by looking at its modified date
        if(knownDbAsset.modifiedAt != asset.modifiedDateTime) {
          modifiedAssets.add(asset);
        }
      }

      // 3. now we handle all the changes.
      List<LocalMedia> newDbAssets = [];
      for(AssetEntity newAsset in newAssets) {
        newDbAssets.add(LocalMedia(id: newAsset.id, folder: folder.id, modifiedAt: newAsset.modifiedDateTime, filePath: (await newAsset.loadFile())!.path));
      }
      await mediaBox.addAllLocalMedia(newDbAssets);

      List<LocalMedia> modifiedDbAssets = [];
      for(AssetEntity modifiedAsset in modifiedAssets) {
        modifiedDbAssets.add(LocalMedia(id: modifiedAsset.id, folder: folder.id, modifiedAt: modifiedAsset.modifiedDateTime, filePath: (await modifiedAsset.loadFile())!.path));
      }
      await mediaBox.updateAllLocalMedia(modifiedDbAssets);

      if(newAssets.length + modifiedAssets.length > 0) {
        mainSendPort.send("partial_collect.1 ${folder.name}: ${newAssets.length} ${modifiedAssets.length}");
      }
    }

    // 4. after partially adding/updating assets of this folder,
    // we should delete all assets that are removed from the device
    // in one db request. they are located in knownDbAssets
    List<LocalMedia> deletedDbAssets = knownDbAssets.values.toList();
    await mediaBox.deleteAllLocalMedia(deletedDbAssets);
    if (deletedDbAssets.isNotEmpty) {
      mainSendPort.send("partial_collect.2 ${folder.name}: ${deletedDbAssets.length}");
    }

    // it is all for now for this folder! moving on to the next one.
  }
  return mediaBox.localMediaLength();
}