import 'package:flutter/material.dart';
import 'orders_main_screen.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({Key? key}) : super(key: key);

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const OrdersMainScreen();
  }
}
