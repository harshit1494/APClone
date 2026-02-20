import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../widgets/custom_text_widget.dart';
import 'orders_screen.dart';

class OrdersMainScreen extends StatefulWidget {
  final dynamic arguments;
  final bool toGtd;
  final bool toBasket;
  final bool toSip;

  const OrdersMainScreen({
    Key? key,
    this.arguments,
    this.toGtd = false,
    this.toSip = false,
    this.toBasket = false,
  }) : super(key: key);

  @override
  State<OrdersMainScreen> createState() => _OrdersMainScreenState();
}

class _OrdersMainScreenState extends State<OrdersMainScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<int> _tabIndex = ValueNotifier<int>(0);

  final List<String> _tabs = [
    'Orders',
    'GTD',
    'My Basket',
    'SIP',
  ];

  @override
  void initState() {
    super.initState();
    
    // Determine initial tab index
    int initialIndex = 0;
    if (widget.arguments != null && widget.arguments['selectedOrderTab'] != null) {
      final tabIdx = _tabs.indexOf(widget.arguments['selectedOrderTab']);
      if (tabIdx != -1) {
        initialIndex = tabIdx;
      }
    }
    
    if (widget.toBasket) {
      initialIndex = _tabs.indexOf('My Basket');
    }
    if (widget.toSip) {
      initialIndex = _tabs.indexOf('SIP');
    }
    if (widget.toGtd && _tabs.contains('GTD')) {
      initialIndex = _tabs.indexOf('GTD');
    }
    
    if (initialIndex == -1) {
      initialIndex = 0;
    }

    _tabIndex.value = initialIndex;
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: initialIndex,
    );
    
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _tabIndex.value = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _tabIndex,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  toolbarHeight: AppWidgetSize.dimen_40,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  flexibleSpace: Container(
                    alignment: Alignment.bottomCenter,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: AppWidgetSize.dimen_2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: Theme.of(context).primaryTextTheme.headlineMedium,
                      labelColor: Theme.of(context).primaryTextTheme.headlineMedium!.color,
                      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
                      unselectedLabelColor: Theme.of(context).textTheme.labelLarge!.color,
                      tabs: _tabs.map((String item) => Tab(child: Text(item))).toList(),
                    ),
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _tabs.map((String item) => _buildTabBarBodyView(item)).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabBarBodyView(String tabName) {
    switch (tabName) {
      case "Orders":
        return const OrdersScreen();
      case "GTD":
        return Center(
          child: CustomTextWidget(
            'GTD Orders Screen (Placeholder)',
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20.w),
          ),
        );
      case "My Basket":
        return Center(
          child: CustomTextWidget(
            'My Basket Screen (Placeholder)',
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20.w),
          ),
        );
      case "SIP":
        return Center(
          child: CustomTextWidget(
            'SIP Orders Screen (Placeholder)',
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20.w),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}

