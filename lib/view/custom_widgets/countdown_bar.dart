import 'package:flutter/material.dart';

class CountdownBar extends StatefulWidget {
  AnimationController anim;

  CountdownBar({Key? key, required this.anim}) : super(key: key);

  @override
  _CountdownBarState createState() => _CountdownBarState();
}

class _CountdownBarState extends State<CountdownBar>
    with TickerProviderStateMixin {
  // late AnimationController controller;

  @override
  void initState() {
    widget.anim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    widget.anim.reverse(from: 10.0);
    super.initState();
  }

  @override
  void dispose() {
    widget.anim.dispose();
    super.dispose();
  }

  String _getVal(double val) {
    return (val * 10).round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LinearProgressIndicator(value: widget.anim.value, minHeight: 12),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _getVal(widget.anim.value),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
