// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:line_icons/line_icons.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final Iterable<String>? autofillHints;
  final bool? isReadOnly;
  final String? text;
  const RoundedPasswordField(
      {Key? key,
      this.onChanged,
      this.textController,
      this.autofillHints,
      this.isReadOnly,
      this.text})
      : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isObscure,
        enableInteractiveSelection: true,
        enableIMEPersonalizedLearning: true,
        enableSuggestions: true,

        // enabled: widget.isEnabled,
        onChanged: widget.onChanged,
        readOnly: widget.isReadOnly ?? false,
        // cursorColor: kActiveBtnColor,
        controller: widget.textController,
        autofillHints: widget.autofillHints,
        // onEditingComplete: () => TextInput.finishAutofillContext(),
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: "Password",
          labelText: widget.text,
          icon: const Icon(
            LineIcons.key,
            color: kPrimaryColor,
          ),
          suffix: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
