
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String address;

  UserModel(
    {
      required this.name, 
      required this.lastName, 
      required this.gender, 
      required this.email, 
      required this.phone, 
      required this.address,
    }
  );
  


  @override
  String toString() {
    return 'UserModel(name: $name, lastName: $lastName, gender: $gender, email: $email, phone: $phone, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.lastName == lastName &&
      other.gender == gender &&
      other.email == email &&
      other.phone == phone &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      lastName.hashCode ^
      gender.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode;
  }
}
