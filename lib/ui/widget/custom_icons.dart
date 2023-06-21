import 'package:flutter/material.dart';

class IconButtonBack extends StatelessWidget {
  final Color color;
  const IconButtonBack({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_rounded),
      color: color,
      iconSize: 24,
    );
  }
}
