// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'text_field_container.dart';

class RectangularPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final Iterable<String>? autofillHints;
  final bool? isReadOnly;
  final IconData? icon;
  final String? text;
  const RectangularPasswordField(
      {Key? key,
      this.onChanged,
      this.textController,
      this.autofillHints,
      this.isReadOnly,
      this.text,
      this.icon})
      : super(key: key);

  @override
  State<RectangularPasswordField> createState() =>
      _RectangularPasswordFieldState();
}

class _RectangularPasswordFieldState extends State<RectangularPasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isObscure,
        enableInteractiveSelection: true,
        enableIMEPersonalizedLearning: true,
        enableSuggestions: true,
        // textAlign: TextAlign.right,
        onChanged: widget.onChanged,
        readOnly: widget.isReadOnly ?? false,
        // cursorColor: kActiveBtnColor,
        controller: widget.textController,
        autofillHints: widget.autofillHints,
        // maxLines: 1,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.normal,
            ),

        // onEditingComplete: () => TextInput.finishAutofillContext(),
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: "Password",
          labelText: widget.text,
          hintStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.normal),
          hintMaxLines: 1,
          icon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.white,
                )
              : null,
          suffix: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: Get.size.height * 0.01),
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.white),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
