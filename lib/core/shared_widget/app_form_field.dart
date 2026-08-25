import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/constants/app_size.dart';

class AppFormField extends StatefulWidget {
  final String? label;
  final String titel;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final VoidCallback? onSuffixPressed;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool isSearcch;
  final bool obscureText;
  const AppFormField({
    super.key,
    this.validator,
    required this.titel,
    this.hintText,
    this.isSearcch = false,
    this.onSubmitted,
    this.textInputAction,
    this.suffixIcon,
    this.onSuffixPressed,
    this.label,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titel, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSize.h8),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obscureText && !_isVisible,
          textInputAction: widget.isSearcch
              ? TextInputAction.search
              : widget.textInputAction,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                  )
                : null,
            labelText: widget.label,
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.r12)),
          ),
        ),
      ],
    );
  }
}

class AppValidators {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';

    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    if (!regex.hasMatch(v.trim())) {
      return 'Invalid email';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password required';
    // final regex = RegExp(
    //   r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    // );
    // if (!regex.hasMatch(v)) {
    //   return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.';
    // }
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v.isEmpty) return 'Phone required';

    if (v.length < 8) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? number(String? v) {
    if (v == null || v.isEmpty) return 'Required';

    if (int.tryParse(v) == null) {
      return 'Must be a number';
    }
    return null;
  }
}
