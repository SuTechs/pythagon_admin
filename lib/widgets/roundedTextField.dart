import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';

import '../constants.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final bool autoFocus;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const RoundedTextField({
    Key? key,
    required this.hintText,
    this.autoFocus = false,
    this.inputFormatters,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'RoundedSearchBarLol00',
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Provider.of<User>(context).isDarkMode
              ? kDarkModeSecondaryColor
              : kLightModeSecondaryColor,
        ),
        child: TextFormField(
          validator: validator,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          autofocus: autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            isDense: true,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
