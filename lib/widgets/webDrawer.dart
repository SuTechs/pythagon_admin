import 'package:flutter/material.dart';

import '../constants.dart';

class WebDrawer extends StatelessWidget {
  final int selectedIndex;
  final List<NavTabData> tabs;
  final ValueChanged<int> onTabChange;

  WebDrawer({
    Key? key,
    this.selectedIndex = 0,
    required this.tabs,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kForegroundColor,
      ),
      child: SafeArea(
        child: Container(
          color: kForegroundColor,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// logo
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 65.0,
                      height: 65.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "PYTHAGON",
                    style: TextStyle(
                        color: kTextDarkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )
                ],
              ),

              /// tabs
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int index = 0; index < tabs.length; index++)
                    if (index == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NavItem(
                            onTap: () => onTabChange(index),
                            item: tabs[index],
                            isSelected: index == selectedIndex,
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Details",
                              style: TextStyle(
                                color: kTextLightGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      )
                    else
                      NavItem(
                        onTap: () => onTabChange(index),
                        item: tabs[index],
                        isSelected: index == selectedIndex,
                      ),
                ],
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
  final void Function() onTap;

  const NavItem({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? kActiveTabGradient
                : [kForegroundColor, kForegroundColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        onTap: onTap,
        selected: isSelected,
        leading: Icon(
          item.icon,
          color: isSelected ? Colors.white : kTextColor,
          size: 18,
        ),
        trailing: isSelected
            ? Icon(
                Icons.arrow_forward_ios_rounded,
                color: isSelected ? Colors.white : kTextColor,
                size: 12,
              )
            : null,
        title: Text(
          item.title,
          style: TextStyle(
            color: isSelected ? Colors.white : kTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        dense: true,
        horizontalTitleGap: 4,
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
