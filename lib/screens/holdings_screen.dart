import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../widgets/custom_text_widget.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({Key? key}) : super(key: key);

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: CustomTextWidget(
          'Holdings',
          Theme.of(context).textTheme.displayMedium!,
        ),
      ),
    );
  }
}

