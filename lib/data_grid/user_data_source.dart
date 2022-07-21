
import 'package:flutter/material.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({required List<UserModel> users}) {
    _users = users.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'lastName', value: e.lastName),
      DataGridCell<String>(columnName: 'gender', value: e.gender),
      DataGridCell<String>(columnName: 'email', value: e.email),
      DataGridCell<String>(columnName: 'phone', value: e.phone),
      DataGridCell<String>(columnName: 'address', value: e.address),
    ])).toList();
  }


  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(8),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }

}