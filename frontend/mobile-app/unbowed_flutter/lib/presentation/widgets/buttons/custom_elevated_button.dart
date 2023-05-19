import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/styles/button.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;

  const CustomElevatedButton({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: primaryButtonStyle,
      child: Text(text),
    );
  }
}
