import 'package:flutter/material.dart';

import '../constants.dart';

class WebDrawer extends StatelessWidget {
  final int selectedIndex;
  final List<NavTabData> items;
  final ValueChanged<int> onItemSelected;

  WebDrawer({
    Key? key,
    this.selectedIndex = 0,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: foregroundColor,
      ),
      child: SafeArea(
        child: Container(
          color: foregroundColor,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 8.0,),

                  Image.asset(
                    "assets/logo.png",
                    width: 65.0,
                    height: 65.0,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8.0,),
                  Text(
                    "PYTHAGON",
                    style: TextStyle(
                        color: textDarkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                title: Text(
                  "Dashboard",
                  style: TextStyle(color: textDarkGrey,fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Details",
                  style: TextStyle(color: textLightGrey,fontWeight: FontWeight.w600,fontSize: 16),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return GestureDetector(
                    onTap: () => onItemSelected(index),
                    child: NavItem(
                      item: item,
                      isSelected: index == selectedIndex,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final bool isSelected;
  final NavTabData item;

  const NavItem({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isSelected
                  ? activeTabGradient
                  : [foregroundColor, foregroundColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        selected: isSelected,
        leading: Icon(
          item.icon,
          color: isSelected ? Colors.white : textColor,
        ),
        title: Text(
          item.title,
          style: TextStyle(color: isSelected ? Colors.white : textColor,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class NavTabData {
  NavTabData({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
