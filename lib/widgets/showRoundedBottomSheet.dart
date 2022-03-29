// import 'package:flutter/material.dart';
//
// import '../constants.dart';
//
// Future<T?> showRoundedBottomSheet<T>({
//   required BuildContext context,
//   required Widget child,
// }) {
//   return showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//         side: BorderSide(
//           color: kActiveColor,
//         ),
//       ),
//       context: context,
//       builder: (context) => child);
// }
//
// class SelectFromList<T> extends StatefulWidget {
//   final void Function(T selectedItem) onSelect;
//   final List<T> items;
//
//   SelectFromList({
//     Key? key,
//     required this.items,
//     required this.onSelect,
//   }) : super(key: key);
//
//   @override
//   _SelectFromListState<T> createState() => _SelectFromListState<T>();
// }
//
// class _SelectFromListState<T> extends State<SelectFromList<T>> {
//   final List<T> listItems = [];
//   String newTitle = '';
//
//   @override
//   void initState() {
//     listItems.addAll(widget.items);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         /// search bar
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Row(
//             children: [
//               SizedBox(width: 12),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24.0),
//                   ),
//                   child: TextField(
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(0),
//                       border: InputBorder.none,
//                       isDense: true,
//                       hintText: 'Search...',
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         newTitle = value;
//                         listItems.clear();
//                         listItems.addAll(widget.items);
//                         listItems.retainWhere((element) => element
//                             .toString()
//                             .toLowerCase()
//                             .contains(value.trim().toLowerCase()));
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12),
//             ],
//           ),
//         ),
//
//         /// items list
//         Expanded(
//           child: ListView.separated(
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 onTap: () {
//                   widget.onSelect(listItems[index]);
//                   Navigator.pop(context);
//                 },
//                 title: Text('${listItems[index].toString()}'),
//               );
//             },
//             separatorBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 70),
//                 child: Container(
//                   height: 0.1,
//                   color: kActiveColor,
//                 ),
//               );
//             },
//             itemCount: listItems.length,
//           ),
//         ),
//       ],
//     );
//   }
// }
