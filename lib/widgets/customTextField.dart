import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pythagon_admin/constants.dart';

class PriceTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixText;
  final TextStyle? textStyle;
  final double? initialPrice;
  final void Function(double?)? onPriceChanged;
  final FormFieldValidator<String>? validator;
  final bool autoFocus;

  const PriceTextField({
    Key? key,
    this.textStyle,
    this.initialPrice,
    this.onPriceChanged,
    this.hintText,
    this.validator,
    this.prefixText,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.end,
      autofocus: autoFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: textStyle,
      initialValue: initialPrice != null ? initialPrice.toString() : null,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: InputBorder.none,
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixText != null
            ? Text(
                prefixText!,
                style: TextStyle(color: kTextDarkGrey),
              )
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      onChanged: (v) {
        print(v);
        if (onPriceChanged != null) onPriceChanged!(double.tryParse(v));
      },
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final String? initialDesc;
  final String? hintText;
  final void Function(String) onDescChanged;
  final _focus = FocusNode();
  final TextStyle? style;
  final OutlineInputBorder? border;

  DescriptionTextField({
    Key? key,
    this.initialDesc,
    required this.onDescChanged,
    this.style,
    this.border,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focus,
      onKey: (key) {
        if (key.isShiftPressed && key.isKeyPressed(LogicalKeyboardKey.enter))
          _focus.unfocus();
      },
      child: Scrollbar(
        child: TextFormField(
          style: style,
          onChanged: (v) {
            if (v.trim().length > 0) onDescChanged(v.trim());
          },
          // validator: (v) {
          //   if (v != null && v.trim().length < 1)
          //     return 'Description is required';
          //   return null;
          // },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialDesc,
          maxLines: null,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            isDense: true,
            hintText: hintText,
            focusedBorder: border,
            enabledBorder: border,
          ),
        ),
      ),
    );
  }
}

class SingleLineTextField extends StatelessWidget {
  final String? initialText;
  final TextStyle? style;

  const SingleLineTextField({Key? key, this.initialText, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      initialValue: initialText,
      onChanged: (v) {},
      validator: (v) {
        if (v != null && v.trim().length < 1) return 'Name is required';
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(60),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
        isDense: true,
        hintText: 'Name',
      ),
    );
  }
}

class DropdownPickerWithIcon extends StatefulWidget {
  final List<String> options;
  final List<IconData> optionsIcon;
  final String hint;
  final List<Color> colors;

  const DropdownPickerWithIcon({
    Key? key,
    required this.options,
    required this.optionsIcon,
    required this.hint,
    required this.colors,
  })  : assert(
            options.length == optionsIcon.length &&
                options.length == colors.length,
            'Icons and Labels length must be same'),
        super(key: key);

  @override
  _DropdownPickerWithIconState createState() => _DropdownPickerWithIconState();
}

class _DropdownPickerWithIconState extends State<DropdownPickerWithIcon> {
  int? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        hint: Text(widget.hint),
        isExpanded: true,
        value: value,
        items: [
          for (int i = 0; i < widget.options.length; i++)
            DropdownMenuItem(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                dense: true,
                horizontalTitleGap: 0,
                leading: CircleAvatar(
                  radius: 12,
                  backgroundColor: widget.colors[i].withOpacity(0.12),
                  child: Icon(
                    widget.optionsIcon[i],
                    color: widget.colors[i],
                    size: 16.0,
                  ),
                ),
                title: Text(widget.options[i]),
              ),
              value: i,
            )
        ],
        onChanged: (index) {
          setState(() {
            value = index;
          });
        },
        icon: SizedBox.shrink(),
      ),
    );
  }
}

/// icon single line tex field
class IconTextField extends StatelessWidget {
  final String? hintText;
  final String labelText;
  final IconData icon;

  final bool isMultipleLine;
  final String? initialText;

  final FormFieldValidator<String>? validator;

  final bool readOnly;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;

  const IconTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.hintText,
    this.initialText,
    this.validator,
    this.isMultipleLine = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: !isMultipleLine ? 1 : null,
      initialValue: initialText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: hintText,
        labelText: labelText,
        icon: Icon(icon),
      ),
      onChanged: onChanged,
    );
  }
}

/// drop down text field
class DropdownTextField extends StatefulWidget {
  const DropdownTextField({
    Key? key,
    required this.options,
    required this.icon,
    required this.labelText,
    this.hintText,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final List<String> options;
  final IconData icon;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState<T> extends State<DropdownTextField> {
  late String? _value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: [
        for (final v in widget.options)
          DropdownMenuItem(
            child: Text(
              v,
              style: TextStyle(fontSize: 14),
            ),
            value: v,
          )
      ],
      value: _value,
      onChanged: (v) {
        setState(() {
          _value = v;
        });
        if (widget.onChanged != null) widget.onChanged!(v);
      },
      style: TextTheme().subtitle1?.copyWith(fontSize: 14),
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        icon: Icon(widget.icon),
      ),
    );
  }
}

// class IconTextField0 extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final IconData icon;
//   final bool readOnly;
//   final bool obscureText;
//   final TextEditingController controller;
//   final void Function()? onTap;
//   final void Function()? onSubmit;
//   final TextInputAction textInputAction;
//   final bool isRequired;
//   final int? maxLine;
//   final TextInputType? keyboardType;
//   final Iterable<String>? autofillHints;
//
//   const IconTextField0(
//       {Key? key,
//       required this.labelText,
//       required this.icon,
//       required this.controller,
//       this.hintText = '',
//       this.readOnly = false,
//       this.obscureText = false,
//       this.textInputAction = TextInputAction.next,
//       this.onTap,
//       this.onSubmit,
//       this.isRequired = false,
//       this.maxLine = 1,
//       this.keyboardType,
//       this.autofillHints})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon),
//       title: TextFormField(
//         autofillHints: autofillHints,
//         keyboardType: keyboardType,
//         maxLines: maxLine,
//         onEditingComplete: onSubmit,
//         validator: (v) {
//           if (isRequired && (v == null || v.trim().length < 1))
//             return '$labelText is required';
//
//           return null;
//         },
//         controller: controller,
//         onTap: onTap,
//         textInputAction: textInputAction,
//         readOnly: readOnly,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(0),
//           border: InputBorder.none,
//           isDense: true,
//           hintText: hintText,
//           labelText: labelText,
//         ),
//       ),
//     );
//   }
// }
