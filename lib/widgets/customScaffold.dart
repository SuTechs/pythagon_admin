import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold({
    required Widget body,
    PreferredSizeWidget? bottom,
  }) : super(
          body: body,
          appBar: AppBar(
            title: Text(
              'This is Heading',
              style: TextStyle(
                color: kActiveColor,
              ),
            ),
            iconTheme: IconThemeData(
              color: kActiveColor,
            ),
            bottom: bottom,
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 64,
            actions: [
              /// notification bell
              InkWell(
                onTap: () {},
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 40.0,
                        width: 32.0,
                      ),
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 32.0,
                        color: Colors.black,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 18.0,
                          width: 18.0,
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),

              /// name & id
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Uchit Chakma",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "#34834",
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
              SizedBox(
                width: 8.0,
              ),

              /// Profile Pic
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16.0),
            ],
          ),
          // backgroundColor: Colors.transparent,

          backgroundColor: kBackgroundColor,
        );
}
