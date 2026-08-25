import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final TextStyle? textStyle;
  final Color? iconColor;

  const AppButton({
    super.key,
    this.icon,
    this.iconColor,
    this.textStyle,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.h45,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: AppSize.w20,
                height: AppSize.h20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon == null) {
      return Text(text, style: textStyle);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: AppSize.r18, color: iconColor),
        SizedBox(width: AppSize.w8),
        Text(text, style: textStyle),
      ],
    );
  }
}
