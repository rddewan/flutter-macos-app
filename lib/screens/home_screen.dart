import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_demo/data_grid/user_data_source.dart';
import 'package:macos_demo/data_grid/user_grid_data_source_editable.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:macos_demo/models/user_model_datagrid.dart';
import 'package:macos_demo/screens/add_user_screen.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<UserModel> userBox;
  late UserGridDataSourceEditable _userDataSource;
  late List<UserModelDatGrid> users;
  bool isDataGridView = false;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user_box');
    users = userBox.values.map((e) => UserModelDatGrid(
      id: e.key,
      name: e.name, 
      lastName: e.lastName, 
      gender: e.gender, 
      email: e.email, 
      phone: e.phone, 
      address: e.address)).toList();

    _userDataSource = UserGridDataSourceEditable(users: users);
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('Home'),
        titleWidth: 100,
        actions: [
          ToolBarIconButton(
            label: 'New User', 
            icon: MacosIcon(CupertinoIcons.add), 
            showLabel: false,
            tooltipMessage: 'Add new user',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddUserScreen()));
            },
          ),
          ToolBarIconButton(
            label: 'Cahnage View', 
            icon: MacosIcon(CupertinoIcons.list_bullet), 
            showLabel: false,
            tooltipMessage: 'Show and hide the data grid',
            onPressed: () {
             setState(() {
               isDataGridView = !isDataGridView;
             });              
            },
          ),
          ToolBarIconButton(
            label: 'ShowHideSideBar', 
            icon: MacosIcon(CupertinoIcons.shuffle), 
            showLabel: false,
            tooltipMessage: 'Show and hide the sidebar',
            onPressed: () {
              MacosWindowScope.of(context).toggleSidebar();              
            },
          ),
          ToolBarPullDownButton(
            label: 'Export', 
            icon: CupertinoIcons.ellipsis_circle, 
            items: [
              MacosPulldownMenuItem(
                label: 'PDF',
                title: const Text('PDF'),
                onTap: () {
                  debugPrint('Export to PDF');
                },
              ),
              MacosPulldownMenuItem(
                label: 'Excel',
                title: const Text('Excel'),
                onTap: () {
                  debugPrint('Export to Excel');
                },
              ),
              MacosPulldownMenuItem(
                label: 'Image',
                title: const Text('Image'),
                onTap: () {
                  debugPrint('Export to Image');
                },
              ),
            ],
          ),
                             
        ],
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDataGridView)...[
                Flexible(
                  child: Material(
                    child: SfDataGrid(
                      source: _userDataSource,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      allowSorting: true,
                      allowTriStateSorting: true,
                      frozenColumnsCount: 1,
                      allowEditing: true,
                      selectionMode: SelectionMode.single,
                      navigationMode: GridNavigationMode.cell,
                      allowSwiping: true,
                      swipeMaxOffset: 100,
                      endSwipeActionsBuilder: (context, dataGridRow, rowIndex) {
                        return GestureDetector(
                          onTap: () {
                            showMacosAlertDialog(
                              context: context, 
                              builder: (_) => MacosAlertDialog(
                                appIcon: const MacosIcon(CupertinoIcons.info), 
                                title: Text(
                                  'Delete Record', 
                                  style: MacosTheme.of(context).typography.headline,
                                ), 
                                message: const Text('Do you want to delete the record'), 
                                primaryButton: PushButton(
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {                                    
                                    userBox.deleteAt(rowIndex);
                                    _userDataSource.dataGridRows.removeAt(rowIndex);
                                    _userDataSource.updateDateGridSource();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'), 
                                ),
                              ));
                          },
                          child: Container(
                            color: Colors.redAccent,
                            child: const Center(
                              child: MacosIcon(CupertinoIcons.delete,color: Colors.white,),
                            ),
                          ),
                        );
                      },
                      columns: [
                        GridColumn(
                          columnName: 'id', 
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Id'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'name', 
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Name'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'lastName', 
                          width: 200,
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('LastName'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'gender', 
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Gender'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'email', 
                          width: 250,
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Email'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'phone', 
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Phone'),
                          ),
                        ),
                        GridColumn(
                          columnName: 'address', 
                          width: 250,
                          allowSorting: false,
                          label: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: const Text('Address'),
                          ),
                        ),
                      ],
                    ),
                  ))

              ]
              else...[
                Flexible(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: userBox.length,
                    itemBuilder: ((context, index) {
                      final user = userBox.getAt(index) as UserModel;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name),
                              Text(user.lastName),
                              Text(user.gender),
                              Text(user.email),
                              Text(user.phone),
                              Text(user.address),
                            ],
                          )
                      ));
                      
                    }),
                  ),
                ),

              ]
            ],
          );
          
        })
      ],
    );
  }
}