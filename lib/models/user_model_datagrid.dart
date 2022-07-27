

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserModelDatGrid {
  int id;
  String name; 
  String lastName;  
  String gender;
  String email;
  String phone;
  String address;

  UserModelDatGrid(
    {
      required this.id,
      required this.name, 
      required this.lastName, 
      required this.gender, 
      required this.email, 
      required this.phone, 
      required this.address,
    }
  );

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'id', value: id),
      DataGridCell<String>(columnName: 'name', value: name),
      DataGridCell<String>(columnName: 'lastName', value: lastName),
      DataGridCell<String>(columnName: 'gender', value: gender),
      DataGridCell<String>(columnName: 'email', value: email),
      DataGridCell<String>(columnName: 'phone', value: phone),
      DataGridCell<String>(columnName: 'address', value: address),
    ]);
  }
  



  @override
  String toString() {
    return 'UserModelDatGrid(id: $id, name: $name, lastName: $lastName, gender: $gender, email: $email, phone: $phone, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModelDatGrid &&
      other.id == id &&
      other.name == name &&
      other.lastName == lastName &&
      other.gender == gender &&
      other.email == email &&
      other.phone == phone &&
      other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      lastName.hashCode ^
      gender.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode;
  }
}
