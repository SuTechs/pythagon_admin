import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../constants.dart';
import 'customTextField.dart';

class DetailBasicInfoTile extends StatelessWidget {
  final bool isSubject;
  final List<OtherInfoIconTileData> otherInfoData;

  const DetailBasicInfoTile({
    Key? key,
    this.isSubject = true,
    required this.otherInfoData,
  })  : assert(otherInfoData.length == 3, 'OtherInfoTile length should be 3'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Subject name and description
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Subject
              if (isSubject)
                Column(
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "PYTHON",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kTextDarkGrey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "COMP SCIENCE",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: kTextDarkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              else
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

              SizedBox(width: 16),

              /// name & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    SingleLineTextField(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff70697B),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: DescriptionTextField(
                        onDescChanged: (_) {},
                        hintText: 'Enter Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: kTextLightGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    /// Update Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kActiveColor),
                      ),
                      onPressed: () {},
                      child: Text('Update'),
                    ),
                  ],
                ),
              )
            ],
          ),

          /// assignment type
          if (isSubject)
            DropdownPickerWithIcon(
              hint: 'Select Type',
              options: [
                'Session',
                'Assignment',
              ],
              colors: [
                Colors.red,
                Colors.green,
              ],
              optionsIcon: [
                FeatherIcons.clock,
                FeatherIcons.book,
              ],
            ),

          Spacer(),

          /// other info
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getIconTile(otherInfoData[0]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _getIconTile(otherInfoData[1]),
              ),
              _getIconTile(otherInfoData[2]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getIconTile(OtherInfoIconTileData data) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: data.color.withOpacity(0.12),
            ),
            child: Center(
              child: Icon(
                data.iconData,
                color: data.color,
                size: 16.0,
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kTextDarkGrey,
                  fontSize: 16,
                ),
              ),
              Text(
                data.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kTextDarkGrey,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      );
}

class OtherInfoIconTileData {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color color;

  OtherInfoIconTileData(this.title, this.subtitle, this.iconData, this.color);
}

class DetailTabView extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> children;
  final EdgeInsets padding;

  const DetailTabView({
    Key? key,
    required this.tabTitles,
    required this.children,
    required this.padding,
  })  : assert(tabTitles.length == children.length,
            'Tab and children length must be same'),
        super(key: key);

  @override
  State<DetailTabView> createState() => _DetailTabViewState();
}

class _DetailTabViewState extends State<DetailTabView>
    with SingleTickerProviderStateMixin {
  late TabController tabController =
      TabController(length: widget.tabTitles.length, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: kForegroundColor,
          child: TabBar(
            // indicator: BoxDecoration(
            //   color: const Color(0xfff3f2f7),
            // ),
            // isScrollable: false,
            unselectedLabelColor: Color(0xff70697B),
            labelColor: kActiveColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: kActiveColor,
            indicatorWeight: 1.0,
            tabs: [
              for (final title in widget.tabTitles)
                Tab(
                  text: title,
                ),
            ],
            controller: tabController,
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: Container(
            color: kForegroundColor,
            padding: widget.padding,
            child: TabBarView(
              controller: tabController,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}

class AttachmentList extends StatefulWidget {
  final List<String> files;
  final Future<void> Function(List<String> urls) onFilesUpload;
  final Future<void> Function(String url) onFileDelete;

  const AttachmentList({
    Key? key,
    required this.files,
    required this.onFilesUpload,
    required this.onFileDelete,
  }) : super(key: key);

  @override
  _AttachmentListState createState() => _AttachmentListState();
}

class _AttachmentListState extends State<AttachmentList> {
  int? _selectedIndex;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.files.isEmpty)
          Center(
            child: Text('Upload files!'),
          )
        else
          Scrollbar(
            child: ListView.builder(
              itemCount: widget.files.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  onTap: () {
                    setState(() {
                      if (_selectedIndex == index)
                        _selectedIndex = null;
                      else
                        _selectedIndex = index;
                    });
                  },
                  horizontalTitleGap: 4,
                  title: Text(widget.files[index]),
                  leading: CircleAvatar(
                    radius: 12,
                    child: Icon(
                      FeatherIcons.file,
                      size: 14,
                    ),
                  ),
                  trailing: _selectedIndex == index
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.download_outlined,
                                size: 14,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 14,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = null;
                                });
                                widget.onFileDelete(widget.files[index]);
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
          ),

        /// upload file
        Align(
          alignment: Alignment.bottomRight,
          child: _isUploading
              ? CircularProgressIndicator(
                  color: kActiveColor,
                )
              : IconButton(
                  splashRadius: 12,
                  onPressed: () async {
                    setState(() {
                      _isUploading = true;
                      widget.files.add('Files');
                    });

                    await Future.delayed(Duration(seconds: 1));

                    setState(() {
                      _isUploading = false;
                    });
                  },
                  icon: Icon(
                    Icons.upload_outlined,
                    color: kActiveColor,
                  ),
                ),
        )
      ],
    );
  }
}

/// StudentTeacherBasic Info Tile

class StudentTeacherBasicInfo extends StatelessWidget {
  final List<OtherInfoIconTileData> otherInfoData;
  final List<IconTextField> fields;

  const StudentTeacherBasicInfo(
      {Key? key, required this.otherInfoData, required this.fields})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DetailBasicInfoTile(
              isSubject: false,
              otherInfoData: [
                OtherInfoIconTileData(
                  '\$300',
                  'Total',
                  FeatherIcons.dollarSign,
                  kActiveColor,
                ),
                OtherInfoIconTileData(
                  "45/50",
                  'Work',
                  FeatherIcons.briefcase,
                  Colors.red,
                ),
                OtherInfoIconTileData(
                  "Active",
                  'Status',
                  Icons.done,
                  Colors.green,
                ),
              ],
            ),
          ),

          SizedBox(width: 16),

          /// info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      /// username
                      IconTextField(
                        labelText: 'Username',
                        icon: FeatherIcons.user,
                        hintText: 'darksumit',
                        initialText: 'darkSuMit',
                      ),

                      /// phone
                      IconTextField(
                        labelText: 'Phone',
                        icon: FeatherIcons.phone,
                        hintText: '987654321',
                        initialText: '+91 7667323338',
                      ),

                      /// email
                      IconTextField(
                        labelText: 'Email',
                        icon: FeatherIcons.mail,
                        hintText: 'example@mail.com',
                        initialText: 'sumit123210@gmail.com',
                      ),

                      /// college
                      IconTextField(
                        labelText: 'College',
                        icon: FeatherIcons.home,
                        hintText: 'IIT Delhi',
                        initialText: 'Dark College',
                      ),

                      /// branch
                      IconTextField(
                        labelText: 'Branch',
                        icon: FeatherIcons.book,
                        hintText: 'Mechanical Eng',
                        initialText: 'CSE',
                      ),

                      /// join on
                      IconTextField(
                        labelText: 'Join On',
                        icon: FeatherIcons.calendar,
                        hintText: '24 Feb 2022',
                        initialText: '2 March 2022',
                      ),
                    ],
                  ),
                ),

                /// Update Button

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kActiveColor),
                    padding: EdgeInsets.all(12),
                  ),
                  onPressed: () {},
                  child: Text('Update'),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

          // empty space
          SizedBox(width: 32),
        ],
      ),
    );
  }
}
