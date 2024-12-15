import 'dart:isolate';

import 'package:photo_manager/photo_manager.dart';

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
    print('Permission is not accessible.');
    return 0;
  }
  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(onlyAll: true);
  if (paths.isEmpty) {
    print('No paths found.');
    return 0;
  }
  var path = paths.first;
  var totalEntitiesCount = await path.assetCountAsync;
  return totalEntitiesCount;
  List<AssetEntity> total_entities = [];
  while(total_entities.length < totalEntitiesCount) {
    final List<AssetEntity> entities = await path.getAssetListRange(
        start: total_entities.length,
        end: total_entities.length + 100
    );
    total_entities.addAll(entities);
  }
  return total_entities.length;
}