import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool readOnly;
  final bool obscureText;
  final TextEditingController controller;
  final void Function()? onTap;
  final void Function()? onSubmit;
  final TextInputAction textInputAction;
  final bool isRequired;
  final int? maxLine;

  const IconTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.hintText = '',
    this.readOnly = false,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.onSubmit,
    this.isRequired = false,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        maxLines: maxLine,
        onEditingComplete: onSubmit,
        validator: (v) {
          if (isRequired && (v == null || v.trim().length < 1))
            return '$labelText is required';

          return null;
        },
        controller: controller,
        onTap: onTap,
        textInputAction: textInputAction,
        readOnly: readOnly,
        obscureText: obscureText,
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
