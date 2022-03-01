import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../constants.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable(
      {Key? key, required this.headersLabel, required this.dataRows})
      : super(key: key);

  final List<String> headersLabel;
  final List<DataRow> dataRows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 40,
      dataRowHeight: 64.0,
      dividerThickness: 0.4,
      dataRowColor: MaterialStateProperty.all(kForegroundColor),
      headingRowColor: MaterialStateProperty.all(const Color(0xfff3f2f7)),
      columns: [
        for (final label in headersLabel)
          DataColumn(
            label: Text(
              label,
              style: TextStyle(
                color: kTextDarkGrey,
                fontSize: 12,
              ),
            ),
          ),
      ],
      rows: dataRows,
    );
  }

  static DataCell getIdCell(String id, {void Function()? onTap}) => DataCell(
        InkWell(
          onTap: onTap,
          child: Text(
            '#$id',
            style: TextStyle(
              fontSize: 14.0,
              color: const Color(0xff834DF3),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  static DataCell getTypeCell(Color color, IconData icon) => DataCell(
        CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(0.12),
          child: Icon(
            icon,
            color: color,
            size: 14,
          ),
        ),
        placeholder: true,
      );

  /// if [noImageText] is not provide [title] first two char will be used
  static DataCell getBasicInfoCell({
    required String title,
    String? subtitle,
    String? imageUrl,
    IconData? iconData,
    String? noImageText,
    Color color = const Color(0xff834DF3),
  }) {
    if (imageUrl == null && noImageText == null)
      noImageText = title.substring(0, 2);

    return DataCell(
      ListTile(
        dense: true,
        visualDensity: VisualDensity.standard,
        contentPadding: EdgeInsets.all(0),
        horizontalTitleGap: 3,
        leading: ProfileCircle(
          iconData: iconData,
          imageUrl: imageUrl,
          noImageText: noImageText,
          color: color,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff6e6b7b),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xffb9b9c3),
                  fontSize: 11.9,
                  fontWeight: FontWeight.w400,
                ),
              )
            : null,
      ),
    );
  }

  static DataCell getTextCell(String text) => DataCell(
        Text(
          text,
          style: TextStyle(
            color: Color(0xff6e6b7b),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  static DataCell getChipCell(String label, Color color) => DataCell(
        Chip(
          backgroundColor: color.withOpacity(0.12),
          label: Text(label),
          labelStyle: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static DataCell getCommentCell(String text) => DataCell(
        Tooltip(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          message: text,
          textStyle: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: 100,
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xff6e6b7b),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );

  static DataCell getActionCell() => DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              FeatherIcons.send,
              color: Colors.grey,
              size: 16.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Icon(
              FeatherIcons.eye,
              color: Colors.grey,
              size: 16.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Icon(
              FeatherIcons.moreVertical,
              color: Colors.grey,
              size: 16.0,
            ),
          ],
        ),
      );
}

class ProfileCircle extends StatelessWidget {
  final String? imageUrl;
  final String? noImageText;
  final IconData? iconData;
  final Color color;
  final double radius;

  const ProfileCircle(
      {Key? key,
      this.imageUrl,
      this.noImageText,
      this.iconData,
      this.color = kActiveColor,
      this.radius = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color.withOpacity(0.12),
      child: imageUrl != null
          ? Image.network(imageUrl!)
          : iconData != null
              ? Icon(
                  iconData,
                  color: color,
                  size: 14,
                )
              : Text(
                  noImageText!,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
    );
  }
}

class DetailDrawerHeader extends StatelessWidget {
  final VoidCallback? onPressed;

  const DetailDrawerHeader({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 12),
          IconButton(
            icon: Icon(
              Icons.clear,
              color: kActiveColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.done,
              color: kActiveColor,
            ),
            onPressed: onPressed,
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
