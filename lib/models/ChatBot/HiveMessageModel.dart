import 'package:hive/hive.dart';
part 'HiveMessageModel.g.dart';


@HiveType(typeId: 1,adapterName: "ChatModelHiveAdaptor")
class HiveMessages{

  @HiveField(0)
  String message;

  HiveMessages({required this.message});
}