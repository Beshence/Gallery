import 'dart:collection';
import 'dart:io';

import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';

class MediaBox {
  late final Store _store;
  late final Box<LocalMedia> _localMediaBox;
  late final Box<LocalFolder> _localFoldersBox;
  late final Query<LocalMedia> localMediaSortedQuery;

  MediaBox._create(this._store) {
    _localMediaBox = Box<LocalMedia>(_store);
    _localFoldersBox = Box<LocalFolder>(_store);
    localMediaSortedQuery = (_localMediaBox.query()..order(LocalMedia_.modifiedAt, flags: Order.descending)).build();
  }

  static Future<MediaBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final storeDir = join(docsDir.path, "mediabox");
    final Store store;
    if (Store.isOpen(storeDir)) {
      store = Store.attach(getObjectBoxModel(), storeDir);
    } else {
      store = await openStore(directory: storeDir);
    }
    return MediaBox._create(store);
  }

  Future<void> addLocalFolder(LocalFolder folder) => _localFoldersBox.putAsync(folder);

  Future<List<LocalMedia>> getAllLocalMedia() => _localMediaBox.getAllAsync();
  Future<List<LocalMedia>> getAllLocalMediaSorted() => localMediaSortedQuery.findAsync();
  Future<void> addAllLocalMedia(List<LocalMedia> assets) => _localMediaBox.putManyAsync(assets, mode: PutMode.insert);
  Future<void> updateAllLocalMedia(List<LocalMedia> assets) => _localMediaBox.putManyAsync(assets, mode: PutMode.update);
  Future<void> deleteAllLocalMedia(List<LocalMedia> assets) => _localMediaBox.removeManyAsync(List.generate(assets.length, (i) => assets[i].objectBoxId));
  Future<void> dropLocalMedia() => _localMediaBox.removeAllAsync();
  int localMediaLength() => _localMediaBox.count();

  Future<void> dropLocalFolders() => _localFoldersBox.removeAllAsync();
  Future<Map<String, LocalMedia>> getAllAssetsOfLocalFolder(String folder) async =>
      { for (var v in await (_localMediaBox.query(LocalMedia_.folder.equals(folder))).build().findAsync()) v.id : v };
}

@Entity()
class LocalMedia {
  @Id()
  int objectBoxId;
  @Unique()
  String id;
  String folder;
  DateTime modifiedAt;
  String filePath;


  LocalMedia({this.objectBoxId = 0, required this.id, required this.folder, required this.modifiedAt, required this.filePath});
}

@Entity()
class LocalFolder {
  @Id()
  int objectBoxId;
  @Unique()
  String id;
  String name;

  LocalFolder({this.objectBoxId = 0, required this.id, required this.name});
}