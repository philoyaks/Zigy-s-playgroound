// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextfield extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;

  final double? spacing;
  final String? Function(String)? errorCondition;
  final int? maxLength;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter> inputFormatter;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;

  const AppTextfield({
    Key? key,
    this.focusNode,
    this.controller,
    this.hintText = '',
    this.spacing = 24,
    this.errorCondition,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatter = const [],
    this.onChange,
    this.keyboardType,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? errorMessage;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.errorCondition != null) {
          errorMessage = widget.errorCondition!(_controller.text);

          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              // maxLines: null,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatter,
              maxLength: widget.maxLength,
              onChanged: (val) {
                errorMessage = null;
                if (widget.onChange != null) {
                  widget.onChange!(val);
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                // errorText: errorMessage,  //// uncomment this to show error message
                errorStyle: const TextStyle(
                  color: Color(0xfffb4341),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xfffb4341), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),

                counterText: '',
                prefixIcon: widget.prefixIcon,

                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),

                fillColor: const Color(0xfffafafa),
                filled: true,
                hintText: widget.hintText ?? 'First name',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.4)),
                // enabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xffe0e0e0), width: 1),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        errorMessage != null
            ? Row(
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Color(0xfffb4341),
                      fontSize: 12,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: widget.spacing,
        )
      ],
    );
  }
}
