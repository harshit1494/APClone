import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text_widget.dart';
import '../models/symbols_model.dart';
import 'watchlist_list_widget.dart';
import 'markets_cash_screen.dart';
import 'markets_fno_screen.dart';
import 'markets_currency_screen.dart';
import 'markets_commodity_screen.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({Key? key}) : super(key: key);

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen>
    with TickerProviderStateMixin {
  TabController? _mainTabController;
  TabController? _tabControllerCash;
  TabController? _tabControllerFno;
  TabController? _tabControllerCurrency;
  TabController? _tabControllerCommodity;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 4, vsync: this);
    _tabControllerCash = TabController(length: 5, vsync: this);
    _tabControllerFno = TabController(length: 5, vsync: this);
    _tabControllerCurrency = TabController(length: 5, vsync: this);
    _tabControllerCommodity = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController?.dispose();
    _tabControllerCash?.dispose();
    _tabControllerFno?.dispose();
    _tabControllerCurrency?.dispose();
    _tabControllerCommodity?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_mainTabController == null ||
        _tabControllerCash == null ||
        _tabControllerFno == null ||
        _tabControllerCurrency == null ||
        _tabControllerCommodity == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              shadowColor: Theme.of(context).inputDecorationTheme.fillColor,
              flexibleSpace: Container(
                alignment: Alignment.bottomCenter,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TabBar(
                  controller: _mainTabController!,
                    isScrollable: true,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: AppWidgetSize.dimen_2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle:
                        Theme.of(context).primaryTextTheme.headlineMedium,
                    labelColor: Theme.of(context)
                        .primaryTextTheme
                        .headlineMedium!
                        .color,
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.labelLarge,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.labelLarge!.color,
                    tabs: const [
                      Tab(child: Text('Cash')),
                      Tab(child: Text('F&O')),
                      Tab(child: Text('Currency')),
                      Tab(child: Text('Commodity')),
                    ],
                  ),
                ),
              ),
            body: TabBarView(
              controller: _mainTabController!,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: [
                MarketsCashScreen(tabControllerCash: _tabControllerCash!),
                MarketsFNOScreen(tabControllerFno: _tabControllerFno!),
                MarketsCurrencyScreen(tabControllerCurrency: _tabControllerCurrency!),
                MarketsCommodityScreen(tabControllerCommodity: _tabControllerCommodity!),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderScreen(String title) {
    return Center(
      child: CustomTextWidget(
        title,
        Theme.of(context).textTheme.displayMedium!,
      ),
    );
  }
}
