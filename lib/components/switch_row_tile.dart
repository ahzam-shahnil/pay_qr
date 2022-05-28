// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:pay_qr/config/app_constants.dart';

class SwitchRowTile extends StatelessWidget {
  const SwitchRowTile({
    Key? key,
    required ValueNotifier<bool> controller,
    required double width,
    required double height,
    required this.text,
  })  : _physicalController = controller,
        _width = width,
        _height = height,
        super(key: key);

  final ValueNotifier<bool> _physicalController;
  final double _width;
  final double _height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: kCheckBoxTextStyle,
            overflow: TextOverflow.visible,
            maxLines: 2,
          ),
        ),
        SizedBox(
          width: _width * 0.02,
        ),
        AdvancedSwitch(
          controller: _physicalController,
          activeColor: Colors.green,
          inactiveColor: kLightBackColor,
          activeChild: const Text('Ja'),
          inactiveChild: const Text('Nein'),
          width: _width * 0.2,
          height: _height * 0.04,
          thumb: ValueListenableBuilder(
            valueListenable: _physicalController,
            builder: (_, bool value, __) {
              return Icon(value ? Icons.circle_rounded : Icons.circle_outlined);
            },
          ),
        ),
      ],
    );
  }
}
