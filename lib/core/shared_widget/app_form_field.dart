import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titel, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8.0),
        TextFormField(
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onFieldSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          textInputAction: isSearcch ? TextInputAction.search : textInputAction,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixPressed)
                : null,
            labelText: label,
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
    if (v == null || v.isEmpty) return 'Email is required';

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(v)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password required';

    if (v.length < 6) {
      return 'Password must be at least 6 chars';
    }
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
