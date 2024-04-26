import 'package:flutter/material.dart';

class TextFieldLabel extends StatefulWidget {
  const TextFieldLabel({
    required this.title,
    required this.textEditingController,
    this.obscureText,
    this.hintText,
    this.padding,
    super.key,
  });

  final String title;
  final TextEditingController textEditingController;
  final bool? obscureText;
  final String? hintText;
  final EdgeInsets? padding;

  @override
  State<TextFieldLabel> createState() => _TextFieldLabelState();
}

class _TextFieldLabelState extends State<TextFieldLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      padding: widget.padding ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration.collapsed(
              hintText: widget.hintText ?? 'Enter',
              fillColor: Colors.black,
            ),
            obscureText: widget.obscureText ?? false,
          ),
        ],
      ),
    );
  }
}
