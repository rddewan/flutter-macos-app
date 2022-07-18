import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_demo/base/base_form_text_field.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:macos_ui/macos_ui.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late Box<UserModel> userBox;
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  final List<String> _genders = ['M','F','Other'];
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user_box');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MacosScaffold(
      toolBar: ToolBar(
        title: const Text('User'),
        titleWidth: 100,
        actions: [
          ToolBarIconButton(
            label: 'Save', 
            icon: const MacosIcon(CupertinoIcons.add), 
            showLabel: true,
            tooltipMessage: 'Add a new user',
            onPressed: () {
              addUser();
            },
          ),
          ToolBarIconButton(
            label: 'Delete', 
            icon: MacosIcon(CupertinoIcons.delete), 
            showLabel: true,
            tooltipMessage: 'delete a user',
            onPressed: () {
              debugPrint('Delete button clicked');
            },
          ),
        ],
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('First Name: '),
                            BaseFormTextField(
                              controller: firstNameController,
                            ),
                            const SizedBox(width: 8,),
                            const Text('Last Name: '),
                            BaseFormTextField(
                              controller: lastNameController,
                            ),

                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            const Text('Gender: '),
                            Material(
                              type: MaterialType.transparency,
                              child: Container(
                                width: MediaQuery.of(context).size.width/2.5,
                                height: 24,
                                decoration: kDefaultRoundedBorderDecoration,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: _gender,
                                    items: _genders.map(buildMenuItem).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            const Text('Email: '),
                            BaseFormTextField(
                              controller: emailController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            const Text('Phone: '),
                            BaseFormTextField(
                              controller: phoneController,
                            ),
                            const SizedBox(width: 8,),
                            const Text('Address: '),
                            BaseFormTextField(
                              controller: addressController,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
          
              ],
            ),
          );

          
        }),

      ],

    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => 
    DropdownMenuItem(
      value: item,
      child: Text(item),
    );

  
  void addUser() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final user  = UserModel(
        name: firstNameController.text, 
        lastName: lastNameController.text, 
        gender: _gender.toString(), 
        email: emailController.text, 
        phone: phoneController.text, 
        address: addressController.text,
      );

      final result  = await userBox.add(user);
      debugPrint(result.toString());
    }
  }
}