import 'package:hive/hive.dart';
part 'HiveMessageModel.g.dart';


@HiveType(typeId: 1,adapterName: "ChatModelHiveAdaptor")
class HiveMessages{
  @HiveField(0)
  String agent;

  @HiveField(1)
  String message;

  HiveMessages({required this.agent,required this.message});
}