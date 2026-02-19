import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ACMLTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChange;
  final int maxLength;
  final bool isError;
  final bool autofocus;
  final bool obscure;
  final bool isPrefix;
  final String label;
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Key? fieldKey;

  const ACMLTextField({
    Key? key,
    this.focusNode,
    this.onFieldSubmitted,
    required this.textEditingController,
    this.inputFormatters,
    this.autofocus = true,
    this.isError = false,
    this.isPrefix = false,
    required this.label,
    required this.hint,
    this.onChange,
    this.suffixIcon,
    this.obscure = false,
    this.maxLength = 50,
    this.fieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return TextFormField(
      key: fieldKey ?? key,
      showCursor: true,
      enableInteractiveSelection: true,
      toolbarOptions: const ToolbarOptions(
        copy: false,
        cut: false,
        paste: false,
        selectAll: false,
      ),
      autocorrect: false,
      enabled: true,
      autofocus: autofocus,
      onChanged: onChange,
      focusNode: focusNode,
      obscureText: obscure,
      onFieldSubmitted: onFieldSubmitted,
      style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w400,
      ),
      textInputAction: TextInputAction.done,
      inputFormatters: inputFormatters,
      keyboardType: isPrefix ? TextInputType.number : TextInputType.text,
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: 15.w,
          top: 12.w,
          bottom: 12.w,
          right: 10.w,
        ),
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
          fontSize: 16.w,
          color: isLight ? const Color(0xFF0F0F0F) : const Color(0xFFFFFFFF),
        ),
        hintStyle: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
          color: isLight
              ? const Color(0xFF434343).withOpacity(0.64)
              : const Color(0xFFFFFFFF).withOpacity(0.64),
        ),
        counterText: '',
        prefixIconConstraints:
            isPrefix ? const BoxConstraints(minWidth: 0, minHeight: 0) : null,
        prefixIcon: isPrefix
            ? Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Text(
                  "+91",
                  style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                    color: isLight
                        ? const Color(0xFF434343).withOpacity(0.64)
                        : const Color(0xFFFFFFFF).withOpacity(0.64),
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.w),
          borderSide: BorderSide(
            color: isError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).dividerColor,
          ),
        ),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      maxLength: maxLength,
    );
  }
}
