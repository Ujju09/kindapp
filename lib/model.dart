import 'package:hive/hive.dart';
part 'model.g.dart';

///Gratitude model
///21 March, 2022
///Author: Ujjwal

@HiveType(typeId: 0)
class Gratitude extends HiveObject {
  @HiveField(0)
  late String journalLog;
  @HiveField(1)
  late DateTime date;
}
