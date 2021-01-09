import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  final Widget lessWidthChild;
  final Widget moreWidthChild;

  const HomeLayout(
      {Key key, @required this.lessWidthChild, @required this.moreWidthChild})
      : assert(lessWidthChild != null && moreWidthChild != null,
            'Child should not be null'),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          /// less width
          Expanded(
            flex: 3,
            child: lessWidthChild,
          ),
          SizedBox(width: 16),

          /// more width
          Expanded(
            flex: 7,
            child: moreWidthChild,
          )
        ],
      ),
    );
  }
}
