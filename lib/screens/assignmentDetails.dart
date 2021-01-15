import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/assignmentInfoComponents.dart';

import '../constants.dart';

class AssignmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Center(child: Text('hello')),
      ),
      body: AssignmentDetailsLayout(
        details: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: AssignmentInfo(),
        ),
        teacher: TeacherCard(),
        payment: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: PaymentCard(),
        ),
      ),
    );
  }
}

class AssignmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentInfoLayout(
      studentInfo: StudentInfoRow(),
      nameAndSubject: AssignmentNameAndSubject(),
      timeAndType: AssignmentTimeAndType(),
      description: DescriptionTextField(),
      attachments: AttachmentList(),
    );
  }
}

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// due
        Text(
          'Due',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.normal, color: Colors.red),
        ),
        Text(
          '5000/-',
          style: Theme.of(context).textTheme.headline5,
        ),

        Spacer(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// settle
            OutlineButton(
              shape: StadiumBorder(),
              child: Text('Settle'),
              onPressed: () {},
            ),

            /// total
            Text(
              'Total: 10000/-',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        )
      ],
    );
  }
}

class TeacherCard extends StatefulWidget {
  @override
  _TeacherCardState createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;

  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// list
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              controller: _scrollViewController,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: FlutterLogo()),
                  title: Text('Uchit Chakma'),
                  subtitle: Text('Rs 500/-'),
                );
              },
              itemCount: 7,
            ),
          ),
        ),

        /// actions
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: _showAppbar ? kToolbarHeight - 10 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Row(
              children: [
                SizedBox(width: 12),
                FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () {},
                  mini: true,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Provider.of<User>(context).isDarkMode
                          ? kDarkModeSecondaryColor
                          : kLightModeSecondaryColor,
                    ),
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Enter amount',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                /// Float
                SizedBox(
                  height: 38,
                  child: OutlineButton(
                    shape: StadiumBorder(),
                    child: Text('Float'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 12),

                /// Send
                SizedBox(
                  height: 38,
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    child: Text('Select'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
}
