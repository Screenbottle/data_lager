import 'package:data_lager/model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DbService {
  static const messageTableName = 'message';
  late Future<Isar> db;

  DbService() {
    openDb();
  }

  Future<void> putMessagesInDb(Message message) async {
    final isar = await db;
    isar.writeTxn(() => isar.messages.put(message));
  }

  Future<List<Message>> getAllMessagesFromDb() async {
    final isar = await db;
    return await isar.messages.where().findAll();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationCacheDirectory();
      return Isar.open([MessageSchema], directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
