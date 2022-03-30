import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final Widget? image;
  final Color textColor, iconColor, backgroundColor;
  final double? fontSize;
  final double maxWidth;
  final bool outlined;

  const RoundedButton(
      {Key? key,
      required this.outlined,
      required this.onPressed,
      required this.text,
      this.image,
      this.icon,
      this.textColor = Colors.white,
      this.iconColor = Colors.white,
      this.backgroundColor = Colors.black,
      this.fontSize = 16,
      this.maxWidth = 220})
      : super(key: key);

  Text _getText() {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }

  Widget _getButton() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (image != null || icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: (image != null)
                    ? image
                    : Icon(
                        icon,
                        color: iconColor,
                      ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: (image != null || icon != null)
                    ? _getText()
                    : Center(
                        child: _getText(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(color: backgroundColor, width: 2),
            ),
            child: _getButton(),
          )
        : MaterialButton(
            onPressed: onPressed,
            elevation: 4,
            color: backgroundColor,
            shape: const StadiumBorder(),
            child: _getButton(),
          );
  }
}
