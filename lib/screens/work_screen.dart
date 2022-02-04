import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: foregroundColor,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: textDarkGrey,
              labelColor: activeColor,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
              tabs: const [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Billing",
                ),
                Tab(
                  text: "Float",
                ),
                Tab(
                  text: "Assigned",
                ),
                Tab(
                  text: "Review",
                ),
                Tab(
                  text: "Payment",
                ),
                Tab(
                  text: "Close",
                ),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [for (int i = 0; i < 7; i++) WorkBody()],
            ),
          )
        ],
      ),
    );
  }
}

class WorkBody extends StatelessWidget {
  const WorkBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DataTableEntity(
            title: "#",
            children: [
              Text(
                "#5634",
                style: TextStyle(fontSize: 25.0, color: Colors.purple),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "#5634",
                style: TextStyle(fontSize: 25.0, color: Colors.purple),
              )
            ],
          ),
          DataTableEntity(
            title: "TYPE",
            children: [
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          DataTableEntity(
            title: "#",
            children: [
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              )
            ],
          ),
          DataTableEntity(
            title: "TYPE",
            children: [
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          DataTableEntity(
            title: "#",
            children: [
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              )
            ],
          ),
          DataTableEntity(
            title: "TYPE",
            children: [
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          DataTableEntity(
            title: "#",
            children: [
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              )
            ],
          ),
          DataTableEntity(
            title: "TYPE",
            children: [
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          DataTableEntity(
            title: "#",
            children: [
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "#5634",
                style: TextStyle(fontSize: 15.0, color: Colors.purple),
              )
            ],
          ),
          DataTableEntity(
            title: "TYPE",
            children: [
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       height: 60,
      //       padding: EdgeInsets.symmetric(vertical: 24.0),
      //       color: backgroundColor,
      //       child: Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //
      //
      //
      //           // Text(
      //           //   "#",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "TYPE",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "BASIC INFO",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "ISSUE DATE",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "DUE DATE",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "BALANCE",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "STATUS",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //           // Text(
      //           //   "COMMENT",
      //           //   style: TextStyle(
      //           //       color: textDarkGrey,
      //           //       fontWeight: FontWeight.w600,
      //           //       fontSize: 15.0),
      //           // ),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Container(
      //         margin: EdgeInsets.only(bottom: 16.0),
      //         color: foregroundColor,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

class DataTableEntity extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DataTableEntity({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textDarkGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            ),
          ),
          Expanded(
            child: Container(
              color: foregroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          )
        ],
      ),
    );
  }
}
