import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';

class ViewAllComponatnts extends StatelessWidget {
  const ViewAllComponatnts({
    super.key,
    required this.titel,
    required this.onTap,
    this.titleColor,
  });

  final String titel;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.w16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titel,
            style: TextStyle(
              color: titleColor ?? Color(0xfffffcfc),
              fontSize: AppSize.sp16,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              "View all",
              style: TextStyle(
                decorationColor: titleColor ?? Color(0xfffffcfc),
                color: titleColor ?? Color(0xfffffcfc),
                fontSize: AppSize.sp14,
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
