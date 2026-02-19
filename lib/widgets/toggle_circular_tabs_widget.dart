import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';

typedef OnToggle = void Function(int index);

class ToggleCircularTabsWidget extends StatefulWidget {
  final List<String>? labels;
  final double cornerRadius;
  final OnToggle? onToggle;
  final int initialLabel;
  final double minWidth;
  final double height;
  final bool isDisabled;
  final TabController tabController;
  final double? fontSize;

  const ToggleCircularTabsWidget({
    Key? key,
    this.labels,
    this.onToggle,
    this.cornerRadius = 8.0,
    this.initialLabel = 0,
    this.minWidth = 100,
    this.height = 40,
    this.isDisabled = false,
    required this.tabController,
    this.fontSize,
  }) : super(key: key);

  @override
  State<ToggleCircularTabsWidget> createState() =>
      ToggleCircularTabsWidgetState();
}

class ToggleCircularTabsWidgetState extends State<ToggleCircularTabsWidget> {
  late int current;

  @override
  void initState() {
    super.initState();
    current = widget.initialLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(widget.cornerRadius.w),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.all(2.w),
      alignment: Alignment.center,
      height: widget.height.w,
      child: TabBar(
        controller: widget.tabController,
        padding: const EdgeInsets.all(0),
        labelPadding: EdgeInsets.all(2.w),
        indicatorColor: Colors.green,
        indicatorPadding: const EdgeInsets.all(0),
        labelColor: Colors.white,
        indicatorWeight: 0,
        labelStyle: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
              fontSize: widget.fontSize ?? 16.w,
            ),
        unselectedLabelStyle:
            Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                  fontSize: widget.fontSize ?? 16.w,
                ),
        unselectedLabelColor: Theme.of(context).primaryColor,
        indicator: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(widget.cornerRadius),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: List<Widget>.generate(widget.labels!.length, (int index) {
          return Tab(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(widget.labels![index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}

