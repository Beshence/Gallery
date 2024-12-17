import 'dart:isolate';

import 'package:photo_manager/photo_manager.dart';

import '../classes/media.dart';
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
          isolateSendPort.send("collect");
          break;
        case "collect":
          print("Isolate sent ${int.parse(args[0])}.");
          timelineChangeNotifier.updateTimeline();
      }
    });
  }

  @override
  Future<void> isolate(ReceivePort isolateReceivePort, SendPort mainSendPort) async {
    isolateReceivePort.listen((message) async {
      List<String> args = message.split(".");
      var command = args.removeAt(0);
      switch(command) {
        case "ping":
          mainSendPort.send("pong");
          break;
        case "collect":
          mainSendPort.send("collect.${await collectMedia()}");
          break;
      }
    });
  }
}

Future<int> collectMedia() async {
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  if (!ps.hasAccess) {
    return 0;
  }
  final List<AssetPathEntity> folders = await PhotoManager.getAssetPathList(hasAll: false);
  if (folders.isEmpty) {
    return 0;
  }

  final mediaDb = MediaDatabase();

  for(AssetPathEntity folder in folders) {
    int currentAssetsCount = 0;
    int totalAssetsCount = await folder.assetCountAsync;
    while(currentAssetsCount < totalAssetsCount) {
      final List<AssetEntity> assets = await folder.getAssetListRange(
          start: currentAssetsCount,
          end: currentAssetsCount + 100
      );
      for(AssetEntity asset in assets) {
        currentAssetsCount+=1;
        await mediaDb.into(mediaDb.localMedia).insert(LocalMediaCompanion.insert(id: asset.id, name: "noname", modifiedAt: asset.modifiedDateTime));
      }
    }
  }
  List<LocalMediaData> allItems = await mediaDb.select(mediaDb.localMedia).get();
  return allItems.length;
  /*var path = paths.first;
  var totalEntitiesCount = await path.assetCountAsync;

  List<AssetEntity> total_entities = [];
  int currentEntitiesCount
  while(total_entities.length < totalEntitiesCount) {
    final List<AssetEntity> entities = await path.getAssetListRange(
        start: total_entities.length,
        end: total_entities.length + 100
    );
    total_entities.addAll(entities);
  }
  return total_entities.length;*/
}