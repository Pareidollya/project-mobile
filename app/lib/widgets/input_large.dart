import 'package:flutter/material.dart';

class InputLarge extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;

  InputLarge({
    required this.labelText,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  _InputLargeState createState() => _InputLargeState();
}

class _InputLargeState extends State<InputLarge> {
  bool _obscureText = true; // Variável de estado para controlar a visualização
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {}); // Reconstruir o widget quando o foco mudar
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      cursorColor: Colors.yellow,
      obscureText: widget.obscureText ? _obscureText : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        filled: true,
        fillColor: const Color.fromARGB(255, 58, 58, 58),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: _focusNode.hasFocus ? Colors.yellow : Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        suffixIcon: widget.obscureText && _focusNode.hasFocus
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: _togglePasswordView,
              )
            : null,
      ),
    );
  }
}
