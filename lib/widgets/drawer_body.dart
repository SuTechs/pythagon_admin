import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../constants.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  double ratingCount = 4.3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //BASIC INFO
          ListTile(
            title: Text(
              "Basic Info",
              style: TextStyle(
                  color: kTextDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 24.0,
              color: kTextLightGrey,
            ),
          ),
          Container(
            height: 100.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //ProfileImg
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.tealAccent),
                ),
                SizedBox(
                  width: 4,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uchit Chakma",
                      style: TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "91+9876543210",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: kTextLightGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "1.5(48)",
                      style: TextStyle(
                          color: kTextColor2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
          ),

          SizedBox(
            height: 16.0,
          ),

          //STATUS
          ListTile(
            title: Text(
              "Status",
              style: TextStyle(
                  color: kTextDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 24.0,
              ),
              Icon(
                FontAwesome5.check_double,
                color: kGreenActiveColor,
                size: 18.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "Sent",
                style: TextStyle(
                    color: kTextColor2,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              )
            ],
          ),

          SizedBox(
            height: 16.0,
          ),

          //ATTACHMENT
          ListTile(
            title: Text(
              "Attachment",
              style: TextStyle(
                  color: kTextDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
          ),
          ListTile(
            leading: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
            ),
            title: Text(
              "Screenshot82313.jpg",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            trailing: Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 12.0,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 16.0,
          ),

          //PAYMENT
          ListTile(
            title: Text(
              "Payment",
              style: TextStyle(
                  color: kTextDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.0, color: kActiveColor)),
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Currency",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: kTextColor2),
                      ),
                      Container(
                        height: 24.0,
                        width: 24.0,
                        margin: EdgeInsets.symmetric(vertical: 24.0),
                        decoration: BoxDecoration(
                            color: kRedBgColor, shape: BoxShape.circle),
                        child: Center(
                          child: Icon(
                            FeatherIcons.dollarSign,
                            color: kRedActiveColor,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
                      child: Divider(
                        height: 0.6,
                        color: kTextLightGrey.withOpacity(0.3),
                      )),
                  Text(
                    "Range",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: kTextColor2),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MIN",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: kTextDarkGrey),
                      ),
                      Text(
                        r"$500",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: kTextColor2),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MAX",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: kTextDarkGrey),
                      ),
                      Text(
                        r"$50",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: kTextColor2),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(color: kRedBgColor),
                      child: Center(
                          child: Text(
                        "Due",
                        style: TextStyle(
                            color: kRedActiveColor,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),

          //RATING
          ListTile(
            title: Text(
              "Rating",
              style: TextStyle(
                  color: kTextDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 8.0,
              ),
              RatingBar.builder(
                initialRating: ratingCount,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingCount = rating;
                  });
                  print(rating);
                },
              ),
              Text(
                "$ratingCount",
                style: TextStyle(
                    color: kTextLightGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              )
            ],
          ),
          Container(
            constraints: BoxConstraints(minHeight: 120),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.0, color: kActiveColor)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Comment",
                    style: TextStyle(
                        color: kTextDarkGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: kGreenBgColor,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(
                    color: kGreenActiveColor, fontWeight: FontWeight.w700),
              )),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
