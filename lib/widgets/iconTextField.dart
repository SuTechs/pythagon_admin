import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool readOnly;
  final TextEditingController controller;
  final void Function() onTap;
  final TextInputAction textInputAction;

  const IconTextField({
    Key key,
    @required this.labelText,
    @required this.icon,
    @required this.controller,
    this.hintText = '',
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: TextField(
        controller: controller,
        onTap: onTap,
        textInputAction: textInputAction,
        readOnly: readOnly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          isDense: true,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
