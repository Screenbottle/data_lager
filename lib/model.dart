import 'package:isar/isar.dart';

part 'model.g.dart';

@collection
class Message {
  Id id = Isar.autoIncrement;
  String? title;
  String? text;

  
}
