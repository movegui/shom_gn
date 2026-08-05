



import 'package:shom_gn/models/adress_model.dart';
import 'package:shom_gn/models/model.dart';
import 'package:shom_gn/models/open_hours_model.dart';
import 'package:shom_gn/models/user_model.dart';

abstract class StoreModel extends Model {

  final String  phone, email, imageUrl, description;
  final AdressModel address; 
  final List<UserModel?>? staff;
  final List<OpenHoursModel> weeklyHours;
  final StoreTypeModel? storeType;
  double? rating ;
  int? reviewCount;

  StoreModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.description,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.staff,
    required this.weeklyHours,
    required this.storeType,
    required this.address,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  @override
  Map<String, dynamic> toJson() => {
    
    ...super.toJson(),
    'description': description,
    'staff': staff != null && staff!.isNotEmpty? staff!.map((user) {
      return user!.toJson();
    }).toList() : [],
    'email': email,
    'imageUrl': imageUrl,
    'telephon': phone,
    'weeklyHours': weeklyHours.map((weekHour){
      return (weekHour.closeTime != null && weekHour.openTime != null) ?
         weekHour.toJson() : {};
    }).toList(),
    'storeType': storeType?.toJson(),
    'address': address.toJson(), 
    'rating': rating,
    'reviewCount': reviewCount,
  };
}


 abstract class StoreTypeModel extends Model {
  StoreTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt,
  };


  @override
  String toString() {
    // TODO: implement toString
    return  'RestaurantModel(id: $id, name: $name, createdAt: $createdAt)';
  }

}

