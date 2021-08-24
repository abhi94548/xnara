import 'package:hive/hive.dart';
part 'HiveMessageModel.g.dart';


@HiveType(typeId: 1,adapterName: 'ChatModelHiveAdaptor')
class HiveMessages{

  HiveMessages({required this.message});

  @HiveField(0)
  String message;

}