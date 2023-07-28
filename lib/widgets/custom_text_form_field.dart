import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.maxLines,
    this.textInputAction,
    this.initialValue,
    this.hasClearButton = false,
    this.hasObscureToggle = false,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final bool hasClearButton;
  final bool hasObscureToggle;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final ValueNotifier<bool> _suffixIconVisibilityController;
  late final ValueNotifier<bool> _obscureTextController;
  late final ValueNotifier<bool> _errorController;

  @override
  void initState() {
    super.initState();
    _suffixIconVisibilityController = ValueNotifier(false);
    _obscureTextController = ValueNotifier(widget.obscureText);
    _errorController = ValueNotifier(false);
    widget.controller?.addListener(_onTextIsNotEmpty);
  }

  @override
  void dispose() {
    _suffixIconVisibilityController.dispose();
    _obscureTextController.dispose();
    _errorController.dispose();
    widget.controller?.removeListener(_onTextIsNotEmpty);
    super.dispose();
  }

  void _onTextIsNotEmpty() {
    final controller = widget.controller;
    if (controller != null) {
      _suffixIconVisibilityController.value = controller.text.isNotEmpty;
      if (widget.obscureText && controller.text.isEmpty) {
        _obscureTextController.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _errorController,
      builder: (context, hasError, child) => ValueListenableBuilder<bool>(
        valueListenable: _obscureTextController,
        builder: (context, obscureText, child) => TextFormField(
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          style: TextStyle(
            fontSize: 16.sp,
            color: widget.readOnly ? const Color(0xffC3C7CE) : null,
          ),
          maxLines: widget.maxLines,
          obscureText: obscureText,
          validator: (value) {
            final validator = widget.validator;
            if (validator != null) {
              final message = validator(value);
              _errorController.value = message != null;
              return message;
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Color(0xffC3C7CE)),
            filled: widget.readOnly,
            fillColor: const Color(0xfff8f8f8),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 16.0),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffe1e3e6),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorMaxLines: 3,
            errorStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.redAccent,
              fontWeight: FontWeight.w500,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: widget.readOnly
                ? OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffe1e3e6),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                : OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff4E73F8),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
            suffixIconConstraints: const BoxConstraints(
              maxWidth: 32.0,
            ),
            suffixIcon: widget.hasClearButton || widget.hasObscureToggle
                ? ValueListenableBuilder<bool>(
                    valueListenable: _suffixIconVisibilityController,
                    builder: (context, value, child) => value
                        ? widget.hasClearButton
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: widget.controller?.clear,
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 24.0,
                                    color: Color(0xffe1e3e6),
                                  ),
                                ),
                              )
                            : const SizedBox(width: 16.0)
                        : const SizedBox(width: 16.0),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
