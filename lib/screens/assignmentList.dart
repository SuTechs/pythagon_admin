import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';

class AssignmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: HideShowListView(),
    );
  }
}

class AssignmentListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: FlutterLogo()),
      title: Text('Long Long assignment'),
      subtitle: Text('Su'),
    );
  }
}

class HideShowListView extends StatefulWidget {
  @override
  _HideShowListViewState createState() => _HideShowListViewState();
}

class _HideShowListViewState extends State<HideShowListView> {
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;

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
    return Column(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(top: _showAppbar ? 12 : 0),
          height: _showAppbar ? kToolbarHeight - 10 : 0.0,
          duration: Duration(milliseconds: 200),
          child: Row(
            children: [
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color(0xffededed),
                  ),
                  child: Text('Search'),
                ),
              ),
              SizedBox(width: 12),
              CircleAvatar(child: FlutterLogo()),
              SizedBox(width: 12),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: _scrollViewController,
            itemBuilder: (context, index) {
              return AssignmentListTile();
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Container(height: 0.1, color: const Color(0xffF2F2F2)),
              );
            },
            itemCount: 200,
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
