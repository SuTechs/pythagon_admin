import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool readOnly;
  final TextEditingController controller;
  final void Function()? onTap;
  final TextInputAction textInputAction;
  final bool isRequired;

  const IconTextField(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.hintText = '',
      this.readOnly = false,
      this.textInputAction = TextInputAction.next,
      this.onTap,
      this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        validator: (v) {
          if (isRequired && (v == null || v.trim().length < 1))
            return '$labelText is required';

          return null;
        },
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
