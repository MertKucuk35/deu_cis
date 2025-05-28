import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController controller;
  bool? obscureText;
  final String? prefixText; // Add this for the leading text
  final Function(String)? onChanged; // Optional callback
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPassword;

  CustomTextField(
      {this.hint,
      required this.controller,
      this.obscureText,
      this.prefixText, // Add this for the leading text
      this.onChanged,
      this.focusNode,
      this.keyboardType,
      this.inputFormatters,
      this.isPassword});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 0.95),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent,
            prefixIcon: widget.prefixText != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Text(
                      widget.prefixText!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : null,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText!;
                      });
                    },
                    icon: Icon(widget.obscureText == true
                        ? Icons.visibility
                        : Icons.visibility_off))
                : null),
      ),
    );
  }
}
