import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/currentAssignmentBloc.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';

import '../constants.dart';

class PriceTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? textStyle;
  final double? initialPrice;
  final void Function(double?) onPriceChanged;
  final FormFieldValidator<String>? validator;
  final bool autoFocus;

  const PriceTextField({
    Key? key,
    this.textStyle,
    this.initialPrice,
    required this.onPriceChanged,
    required this.hintText,
    this.validator,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      key: Key('${CurrentAssignmentBloc().textFieldKey}'),
      style: textStyle,
      initialValue: initialPrice != null ? initialPrice.toString() : null,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
        isDense: true,
        hintText: hintText,
      ),
      onChanged: (v) {
        onPriceChanged(double.tryParse(v));
      },
    );
  }
}

class ReceivedAmountAndSettleUp extends StatefulWidget {
  final double? receivedAmount;
  final Future<void> Function(double) onSettleUp;

  const ReceivedAmountAndSettleUp(
      {Key? key, this.receivedAmount, required this.onSettleUp})
      : super(key: key);

  @override
  _ReceivedAmountAndSettleUpState createState() =>
      _ReceivedAmountAndSettleUpState();
}

class _ReceivedAmountAndSettleUpState extends State<ReceivedAmountAndSettleUp> {
  bool _isShowSettleUp = false;
  bool _isSettlingUp = false;
  double _settleUpAmount = 0;

  @override
  Widget build(BuildContext context) {
    // ToDo: add logic if assignment is closed
    // if (widget.receivedAmount == 0) // if paid
    //   return Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       /// paid
    //
    //       CircleAvatar(
    //         child: Icon(
    //           Icons.done_outline_rounded,
    //           color: Colors.white,
    //         ),
    //         backgroundColor: Colors.green,
    //       ),
    //       Text(
    //         'Paid',
    //         style: Theme.of(context)
    //             .textTheme
    //             .headline6!
    //             .copyWith(fontWeight: FontWeight.normal, color: Colors.green),
    //       ),
    //     ],
    //   );

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: !_isShowSettleUp
          ? GestureDetector(
              onTap: () {
                if (widget.receivedAmount != null)
                  setState(() {
                    _isShowSettleUp = true;
                  });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// received
                  Text(
                    'Received',
                    // style: Theme.of(context).textTheme.headline6!.copyWith(
                    //     fontWeight: FontWeight.normal, color: Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹ ${widget.receivedAmount ?? 'Amount'}',
                    style: widget.receivedAmount != null
                        ? Theme.of(context).textTheme.headline5
                        : TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Provider.of<UserData>(context).isDarkMode
                          ? kDarkModeSecondaryColor
                          : kLightModeSecondaryColor,
                    ),
                    child: PriceTextField(
                      autoFocus: true,
                      hintText: 'Enter amount',
                      validator: (price) {
                        if (price == null || price.isEmpty)
                          return 'Enter amount!';

                        final p = double.tryParse(price);

                        if (p == null || p <= 0) return 'Invalid amount!';
                      },
                      onPriceChanged: (value) {
                        _settleUpAmount = value ?? 0;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12),

                /// cancel
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  child: Text('Cancel'),
                  onPressed: () {
                    if (!_isSettlingUp)
                      setState(() {
                        _isShowSettleUp = false;
                      });
                  },
                ),
                SizedBox(width: 12),

                /// settle up
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: _isSettlingUp
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text('Settle'),
                  onPressed: () async {
                    if (_isSettlingUp || _settleUpAmount <= 0) return;

                    setState(() {
                      _isSettlingUp = true;
                    });

                    await widget.onSettleUp(_settleUpAmount);

                    setState(() {
                      _isSettlingUp = false;
                      _isShowSettleUp = false;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
