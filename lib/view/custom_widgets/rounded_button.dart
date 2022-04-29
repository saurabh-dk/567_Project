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
  final bool isLoading;

  const RoundedButton(
      {Key? key,
      required this.outlined,
      required this.onPressed,
      required this.text,
      this.image,
      this.icon,
      this.isLoading = false,
      this.textColor = Colors.white,
      this.iconColor = Colors.white,
      this.backgroundColor = const Color.fromARGB(255, 0, 0, 0),
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
            if (!isLoading)
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
            if (!isLoading)
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
            if (isLoading)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                      color: (outlined || (backgroundColor == Colors.white))
                          ? Colors.black
                          : Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return outlined
        ? OutlinedButton(
            onPressed: isLoading ? () {} : onPressed,
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(color: backgroundColor, width: 2),
            ),
            child: _getButton(),
          )
        : MaterialButton(
            onPressed: isLoading ? () {} : onPressed,
            elevation: 4,
            color: backgroundColor,
            shape: const StadiumBorder(),
            child: _getButton(),
          );
  }
}
