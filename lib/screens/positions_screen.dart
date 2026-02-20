import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../widgets/custom_text_widget.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({Key? key}) : super(key: key);

  @override
  State<PositionsScreen> createState() => _PositionsScreenState();
}

class _PositionsScreenState extends State<PositionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: CustomTextWidget(
          'Positions',
          Theme.of(context).textTheme.displayMedium!,
        ),
      ),
    );
  }
}

