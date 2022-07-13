import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class BaseFormTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  const BaseFormTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MacosTextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
      ),
    );
  }
}