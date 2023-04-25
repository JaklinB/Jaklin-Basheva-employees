import 'package:flutter/material.dart';

import '../../helpers/theme_helper.dart';

class AppButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final void Function()? onPressed;
  const AppButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: ThemeHelper.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
      ),
      onPressed: widget.onPressed,
      icon: Icon(
        widget.icon,
        size: 24.0,
      ),
      label: Text(widget.text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    );
  }
}
