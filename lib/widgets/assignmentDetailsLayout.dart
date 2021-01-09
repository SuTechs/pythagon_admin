import 'package:flutter/material.dart';

class AssignmentDetailsLayout extends StatelessWidget {
  final Widget details;
  final Widget payment;
  final Widget teacher;

  const AssignmentDetailsLayout(
      {Key key, this.details, this.payment, this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// details
        Expanded(
          flex: 3,
          child: CustomContainer(child: details),
        ),
        SizedBox(height: 16),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              /// teachers
              Expanded(
                flex: 3,
                child: CustomContainer(child: teacher),
              ),
              SizedBox(width: 16),

              /// payments
              Expanded(
                flex: 2,
                child: CustomContainer(child: payment),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0), color: Colors.white,
        // gradient: LinearGradient(
        //   begin: Alignment(0.1, 1.0),
        //   end: Alignment(0.09, -1.0),
        //   colors: [const Color(0xff15151f), const Color(0xb4000000)],
        //   stops: [0.0, 1.0],
        // ),
      ),
      child: child,
    );
  }
}
