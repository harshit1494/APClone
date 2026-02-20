import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';

typedef OnToggle = void Function(int index);

class ToggleCircularWidget extends StatefulWidget {
  final Color? activeBgColor;
  final Color? activeTextColor;
  final Color? inactiveBgColor;
  final Color? inactiveTextColor;
  final List<String>? labels;
  final double cornerRadius;
  final OnToggle? onToggle;
  final int initialLabel;
  final double minWidth;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;
  final double height;
  final bool isDisabled;

  const ToggleCircularWidget({
    Key? key,
    this.activeBgColor,
    this.activeTextColor,
    this.inactiveBgColor,
    this.inactiveTextColor,
    this.labels,
    this.onToggle,
    this.cornerRadius = 8.0,
    this.initialLabel = 0,
    this.minWidth = 100,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
    required this.height,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<ToggleCircularWidget> createState() => _ToggleCircularWidgetState();
}

class _ToggleCircularWidgetState extends State<ToggleCircularWidget> {
  late int current;

  @override
  void initState() {
    super.initState();
    current = widget.initialLabel;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.cornerRadius),
      child: Container(
        height: widget.height,
        color: widget.inactiveBgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            widget.labels!.length * 2 - 1,
            (int index) {
              final bool active = index ~/ 2 == current;
              final Color textColor =
                  active ? widget.activeTextColor! : widget.inactiveTextColor!;
              final Color bgColor =
                  active ? widget.activeBgColor! : Colors.transparent;

              if (index % 2 == 1) {
                return Container(
                  width: 1,
                  color: widget.inactiveBgColor,
                  margin: EdgeInsets.symmetric(vertical: 4),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    if (!widget.isDisabled) {
                      setState(() {
                        current = index ~/ 2;
                      });
                      if (widget.onToggle != null) {
                        widget.onToggle!(current);
                      }
                    }
                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: widget.minWidth),
                    decoration: BoxDecoration(
                      borderRadius: current == 0 && widget.labels!.length == 2
                          ? BorderRadius.only(
                              topLeft: Radius.circular(widget.cornerRadius),
                              bottomLeft: Radius.circular(widget.cornerRadius),
                            )
                          : current == widget.labels!.length - 1 &&
                                  widget.labels!.length == 2
                              ? BorderRadius.only(
                                  topRight: Radius.circular(widget.cornerRadius),
                                  bottomRight:
                                      Radius.circular(widget.cornerRadius),
                                )
                              : BorderRadius.zero,
                      color: bgColor,
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      widget.labels![index ~/ 2],
                      textAlign: TextAlign.center,
                      style: widget.activeTextStyle.copyWith(color: textColor),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

