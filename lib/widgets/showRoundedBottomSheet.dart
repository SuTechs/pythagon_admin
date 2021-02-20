import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import '../constants.dart';

Future<T?> showRoundedBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: Provider.of<User>(context, listen: false).isDarkMode
              ? kDarkModeSecondaryColor
              : kLightModeSecondaryColor,
        ),
      ),
      context: context,
      builder: (context) => child);
}
