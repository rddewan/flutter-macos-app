import 'package:flutter/cupertino.dart';
import 'package:macos_demo/base/base_form_text_field.dart';
import 'package:macos_ui/macos_ui.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  MacosScaffold(
      toolBar: const ToolBar(
        title: Text('User'),
        titleWidth: 100,
        actions: [
          ToolBarIconButton(
            label: 'Save', 
            icon: MacosIcon(CupertinoIcons.add), 
            showLabel: true,
            tooltipMessage: 'Add a new user'
          ),
          ToolBarIconButton(
            label: 'Delete', 
            icon: MacosIcon(CupertinoIcons.delete), 
            showLabel: true,
            tooltipMessage: 'delete a user'
          ),
        ],
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('First Name: '),
                          BaseFormTextField(
                            controller: firstNameController,
                          ),
                          
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
                          BaseFormTextField(
                            controller: genderController,
                          ),
                         
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
                         
                          const Text('Address: '),
                          BaseFormTextField(
                            controller: addressAddress,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
          
              ],
            ),
          );

          
        }),

      ],

    );
  }
}