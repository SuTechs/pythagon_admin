import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key}) : super(key: key);

  void showNotifDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2.0, color: activeColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: textColor2),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: purpleBgColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        child: Text(
                          "6 new",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              color: activeColor),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 16.0, top: 16),
                    child: Divider(
                      height: 0.6,
                      color: textLightGrey.withOpacity(0.3),
                    )),
                ListTile(
                  leading: Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        color: Colors.teal, shape: BoxShape.circle),
                  ),
                  title: Text(
                    "New Student",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: textColor2),
                  ),
                  subtitle: Text(
                    "Hello uchit this is uchit and this..",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: textLightGrey),
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        color: Colors.teal, shape: BoxShape.circle),
                  ),
                  title: Text(
                    "New Student",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: textColor2),
                  ),
                  subtitle: Text(
                    "Hello uchit this is uchit and this..",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: textLightGrey),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 16.0, top: 16),
                    child: Divider(
                      height: 0.6,
                      color: textLightGrey.withOpacity(0.3),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Center(
                        child: Text(
                      "Read all Notifications",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 8.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      showNotifDialog(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 42.0,
                          width: 32.0,
                        ),
                        Icon(
                          Icons.notifications,
                          size: 32.0,
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
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Uchit Chakma",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "#34834",
                        style: TextStyle(fontSize: 16.0, color: Colors.purple),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 16.0,
            // ),
          ],
        ),
      ),
    );
  }
}
