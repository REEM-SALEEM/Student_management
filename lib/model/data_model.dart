import 'package:hive_flutter/adapters.dart';
  part 'data_model.g.dart';
   
@HiveType(typeId: 1)
class StudentModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final dynamic stnd;

  @HiveField(4)
  final dynamic reg;
  
  @HiveField(5)
  final String img;


StudentModel({
  required this.name,
  required this.age,
  this.id,
  required this.stnd,
  required this.reg,
  required this.img});

}