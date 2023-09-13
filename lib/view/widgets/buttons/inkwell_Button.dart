

import 'package:flutter/material.dart';



class InkWellButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color ?textColor;
  final Color ?boxColor;

  const InkWellButton({Key? key, required this.text, required this.onPressed,this.textColor, this.boxColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1 , color: Colors.black12),
          color: boxColor ?? Colors.purpleAccent
        ),
        child: Text(text , style: TextStyle(color: textColor ?? Colors.white),),
      ),
    );
  }
}
