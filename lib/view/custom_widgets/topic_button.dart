import 'package:flutter/material.dart';

class TopicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final Widget? image;
  final Color textColor;
  final double? fontSize;

  const TopicButton({
    Key? key,
    required this.onPressed,
    required this.name,
    this.image,
    this.textColor = Colors.white,
    this.fontSize = 16,
  }) : super(key: key);

  Text _getText() {
    return Text(
      name,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey),
        child: _getText(),
      ),
    );
  }
}
