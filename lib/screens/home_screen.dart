import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_demo/data_grid/user_data_source.dart';
import 'package:macos_demo/models/user_model.dart';
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
  late UserDataSource _userDataSource;
  late List<UserModel> users;
  bool isDataGridView = false;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user_box');
    users = userBox.values.map((e) => UserModel(
      name: e.name, 
      lastName: e.lastName, 
      gender: e.gender, 
      email: e.email, 
      phone: e.phone, 
      address: e.address)).toList();

    _userDataSource = UserDataSource(users: users);
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: Text('Home'),
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
                      columns: [
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