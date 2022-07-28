
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:macos_demo/models/user_model_datagrid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserGridDataSourceEditable extends DataGridSource {
  UserGridDataSourceEditable({required this.users}) {
    dataGridRows = users.map((e) => e.getDataGridRow()).toList();
  }
    

  List<UserModelDatGrid> users = [];
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;
   /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on onCellSubmit method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  Box<UserModel> userBox = Hive.box('user_box');


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {

        Color getCellColor() {
          if (dataGridCell.value == 'M') {
            return Colors.blue;
          }
          else if (dataGridCell.value == 'F') {
            return Colors.pink;
          }
          return  Colors.transparent;
        }

        TextStyle getCellStyle() {
          if (dataGridCell.value == 'M') {
            return const TextStyle(color: Colors.white);
          }
          else if (dataGridCell.value == 'F') {
            return  const TextStyle(color: Colors.white);
          }
           return const TextStyle(color: Colors.black);
        }

        return Container(
          color: getCellColor(),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(8),
          child: Text(
            dataGridCell.value.toString(),
            style: getCellStyle(),
          ),
        );
      }).toList(),


    );
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName).value;

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'id') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'id', value: newCellValue);
      users[dataRowIndex].id = newCellValue as int;
    } else if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name', value: newCellValue);
      users[dataRowIndex].name = newCellValue.toString();
    }else if (column.columnName == 'lastName') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'lastName', value: newCellValue);
      users[dataRowIndex].lastName = newCellValue.toString();
    }else if (column.columnName == 'gender') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'gender', value: newCellValue);
      users[dataRowIndex].gender = newCellValue.toString();
    }else if (column.columnName == 'email') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'email', value: newCellValue);
      users[dataRowIndex].email = newCellValue.toString();
    }else if (column.columnName == 'phone') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'phone', value: newCellValue);
      users[dataRowIndex].phone = newCellValue.toString();
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'address', value: newCellValue);
      users[dataRowIndex].address = newCellValue.toString();
    }

    final value = dataGridRow.getCells().map((e) => e.value).toList();

    if (userBox.containsKey(value[0])) {
      userBox.putAt(
        value[0], 
        UserModel(
          name: value[1], 
          lastName: value[2], 
          gender: value[3], 
          email: value[4], 
          phone: value[5], 
          address: value[5],
        ),
      );
    }
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName).value.toString();
    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType = column.columnName == 'id' ;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  void updateDateGridSource(){
    notifyListeners();
  }


}