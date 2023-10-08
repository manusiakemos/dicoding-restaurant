import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final bool readOnly;
  final bool autoFocus;
  final Function()? onTap;
  final Function(String)? onChanged;

  const TextInput({
    required this.readOnly,
    required this.autoFocus,
    this.onTap,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final String hint = "Search...";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: accentColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: mutedColor),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
