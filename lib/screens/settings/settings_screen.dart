import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';

import '../../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 5,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 32.0,
                  ),
                  SettingsProfileTile(),
                  SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            )),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 32, right: 16.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Change Your Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: kTextColor2),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 16.0, top: 16),
                      child: Divider(
                        height: 0.6,
                        color: kTextLightGrey.withOpacity(0.3),
                      )),
                  Text(
                    "Current",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: kTextColor2),
                  ),
                  Flexible(
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter your Current password",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: kTextLightGrey)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "New Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: kTextColor2),
                  ),
                  Flexible(
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter your Current password",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: kTextLightGrey)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Center(
                          child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}

class SettingsProfileTile extends StatelessWidget {
  const SettingsProfileTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.pink),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Uchit Chakma",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kTextColor2,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Here goes the description about the description of the description to be described ",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextLightGrey,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person_outline_outlined,
                                    size: 18, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Username",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "uchit.chakma123",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,
                                    size: 18, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Phone",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "8979717380",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email_outlined,
                                    size: 18, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Email",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "Sumit@gmail.Com",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesome.bank,
                                    size: 16, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "College",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "Hkbk College Of Eng",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Iconic.book_open,
                                    size: 16, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Branch",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "Computer Science",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today_sharp,
                                    size: 16, color: kTextColor2),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "Joined",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor2,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              "24 Feb 2016",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor2,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }
}
