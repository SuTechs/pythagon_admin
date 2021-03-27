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

class DueAmountAndSettleUp extends StatefulWidget {
  final double? dueAmount;
  final Future<void> Function(double) onSettleUp;

  const DueAmountAndSettleUp(
      {Key? key, this.dueAmount, required this.onSettleUp})
      : super(key: key);

  @override
  _DueAmountAndSettleUpState createState() => _DueAmountAndSettleUpState();
}

class _DueAmountAndSettleUpState extends State<DueAmountAndSettleUp> {
  bool _isShowSettleUp = false;
  bool _isSettlingUp = false;
  double _settleUpAmount = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.dueAmount == 0) // if paid
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// paid

          CircleAvatar(
            child: Icon(
              Icons.done_outline_rounded,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
          ),
          Text(
            'Paid',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.normal, color: Colors.green),
          ),
        ],
      );

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: !_isShowSettleUp
          ? GestureDetector(
              onTap: () {
                if (widget.dueAmount != null)
                  setState(() {
                    _isShowSettleUp = true;
                  });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// due
                  Text(
                    'Due',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.red),
                  ),
                  Text(
                    '${widget.dueAmount ?? 'Amount'}',
                    style: widget.dueAmount != null
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

                        if (p == null || p <= 0 || p > widget.dueAmount!)
                          return 'Invalid amount!';
                      },
                      onPriceChanged: (value) {
                        _settleUpAmount = value ?? 0;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12),

                /// cancel
                SizedBox(
                  width: 32 * 2,
                  height: 32,
                  child: OutlinedButton(
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
                ),
                SizedBox(width: 12),

                /// settle up
                SizedBox(
                  width: 32 * 2,
                  height: 32,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(StadiumBorder()),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
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
                      if (_isSettlingUp ||
                          _settleUpAmount <= 0 ||
                          _settleUpAmount > widget.dueAmount!) return;

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
                ),
              ],
            ),
    );
  }
}
