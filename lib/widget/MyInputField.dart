import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      _obscureText = false;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        )
            : (widget.suffixIcon != null ? Icon(widget.suffixIcon) : null),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}
