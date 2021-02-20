import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import '../constants.dart';
import 'assignmentDetailsLayout.dart';

class SelectFromList<T> extends StatefulWidget {
  final void Function(T selectedItem) onSelect;
  final void Function(String newItem) onNewItemSelect;
  final List<ListItem<T>> items;
  SelectFromList(
      {Key? key,
      required this.items,
      required this.onSelect,
      required this.onNewItemSelect})
      : super(key: key);

  @override
  _SelectFromListState<T> createState() => _SelectFromListState<T>();
}

class _SelectFromListState<T> extends State<SelectFromList<T>> {
  final List<ListItem<T>> listItems = [];
  String newTitle = '';

  @override
  void initState() {
    listItems.addAll(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
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
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Search...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          newTitle = value;
                          listItems.clear();
                          listItems.addAll(widget.items);
                          listItems.retainWhere((element) => element.title
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()));
                        });
                      },
                    ),
                  ),
                ),
                if (newTitle.length > 0) SizedBox(width: 12),
                if (newTitle.length > 0)
                  FloatingActionButton(
                    mini: true,
                    child: Icon(Icons.add),
                    onPressed: () {
                      widget.onNewItemSelect(newTitle);
                      Navigator.pop(context);
                    },
                  ),
                SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      widget.onSelect(listItems[index].value);
                      Navigator.pop(context);
                    },
                    title: Text(listItems[index].title),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Container(
                      height: 0.1,
                      color: Provider.of<User>(context).isDarkMode
                          ? kDarkModeSecondaryColor
                          : kLightModeSecondaryColor,
                    ),
                  );
                },
                itemCount: listItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem<T> {
  final T value;
  final String title;

  ListItem(this.value, this.title);
}
