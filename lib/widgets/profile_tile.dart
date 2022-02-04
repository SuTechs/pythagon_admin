import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  Stack(
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "8",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w800,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
