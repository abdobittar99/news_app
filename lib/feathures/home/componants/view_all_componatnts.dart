import 'package:flutter/material.dart';

class ViewAllComponatnts extends StatelessWidget {
  const ViewAllComponatnts({
    super.key,
    required this.titel,
    required this.onTap,
    this.titleColor,
  });

  final String titel;
  final Color? titleColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titel,
            style: TextStyle(
              color: titleColor ?? Color(0xfffffcfc),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () => onTap,
            child: Text(
              "View all",
              style: TextStyle(
                decorationColor: titleColor ?? Color(0xfffffcfc),
                color: titleColor ?? Color(0xfffffcfc),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
