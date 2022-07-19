import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:macos_demo/screens/add_user_screen.dart';
import 'package:macos_ui/macos_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user_box');
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
              )
            ],
          );
          
        })
      ],
    );
  }
}