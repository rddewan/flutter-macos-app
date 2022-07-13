import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_demo/screens/add_user_screen.dart';
import 'package:macos_ui/macos_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      children: [
        ContentArea(builder: (context, scrollController) {
          return Column(
            children: [
              PushButton(
                buttonSize: ButtonSize.large,
                color: Colors.blue,
                child: Text('New User'), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddUserScreen()));
                },
              )
            ],
          );
          
        })
      ],
    );
  }
}