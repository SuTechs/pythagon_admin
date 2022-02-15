import 'package:flutter/material.dart';

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

  static DataCell getIdCell(String id) => DataCell(
        Text(
          '#$id',
          style: TextStyle(
            fontSize: 14.0,
            color: const Color(0xff834DF3),
            fontWeight: FontWeight.w500,
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
      );

  /// if [noImageText] is not provide [subtitle] first two char will be used
  static DataCell getBasicInfoCell({
    required String title,
    required String subtitle,
    String? imageUrl,
    String? noImageText,
    Color color = const Color(0xff834DF3),
  }) {
    if (noImageText == null) noImageText = subtitle.substring(0, 2);

    return DataCell(
      ListTile(
        dense: true,
        visualDensity: VisualDensity.standard,
        contentPadding: EdgeInsets.all(0),
        horizontalTitleGap: 3,
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(0.12),
          child: imageUrl != null
              ? Image.network(imageUrl)
              : Text(
                  noImageText,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff6e6b7b),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Color(0xffb9b9c3),
            fontSize: 11.9,
            fontWeight: FontWeight.w400,
          ),
        ),
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
}
