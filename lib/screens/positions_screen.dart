import 'package:flutter/material.dart';
import 'orders_main_screen.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({Key? key}) : super(key: key);

  @override
  State<PositionsScreen> createState() => _PositionsScreenState();
}

class _PositionsScreenState extends State<PositionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const OrdersMainScreen();
  }
}
