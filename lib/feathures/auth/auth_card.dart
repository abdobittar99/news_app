import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';

class AuthCard extends StatelessWidget {
  AuthCard({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.all(AppSize.r16),
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
