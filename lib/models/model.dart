import 'package:hive/hive.dart';

abstract class Model extends HiveObject {
  final String id;
     String name;
  final DateTime createdAt;

  Model({
    required this.id,
    required this.name,
    required this.createdAt
  });

 Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'createdAt': createdAt
};

}