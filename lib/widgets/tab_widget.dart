import 'package:flutter/material.dart';

class NavTab extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final Function onTap;

  const NavTab(
      {Key? key,
      required this.icon,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  _NavTabState createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        selectedColor: Colors.pinkAccent,
        selectedTileColor: Colors.yellow,
        selected: widget.selected,
        leading: Icon(
          widget.icon,
          color: Colors.greenAccent,
        ),
        title: Text(widget.title),
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
