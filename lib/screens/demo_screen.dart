import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_images.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text_widget.dart';
import 'watchlist_screen.dart';
import 'trades_screen.dart';
import 'dashboard_screen.dart';
import 'funds_screen.dart';

class DemoScreen extends StatefulWidget {
  final int initialIndex;
  const DemoScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  late int _selectedIndex;
  List<Map<String, dynamic>>? _menuItems;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_menuItems == null) {
      _initializeMenuItems();
    }
  }

  void _initializeMenuItems() {
    _menuItems = [
      {
        'icon': AppImages.watchListDisable(
          context,
          color: Theme.of(context).iconTheme.color,
          isColor: true,
        ),
        'activeIcon': AppImages.addFilledIcon(context),
        'title': 'Watchlist',
      },
      {
        'icon': AppImages.tradeDisable(
          context,
          isColor: true,
          color: Theme.of(context).iconTheme.color,
        ),
        'activeIcon': AppImages.tradeEnabled(context),
        'title': 'Trades',
      },
      {
        'icon': AppImages.dashboardAcmlDisable(
          context,
          color: Theme.of(context).iconTheme.color,
          isColor: true,
        ),
        'activeIcon': AppImages.dashboardeEnabled(context),
        'title': 'Dashboard',
      },
      {
        'icon': AppImages.fundsDisable(
          context,
          color: Theme.of(context).iconTheme.color,
          isColor: true,
        ),
        'activeIcon': AppImages.fundsEnabled(context),
        'title': 'Funds',
      },
      {
        'icon': AppImages.exploreDisable(
          context,
          color: Theme.of(context).iconTheme.color,
          isColor: true,
        ),
        'activeIcon': AppImages.exploreEnabled(context),
        'title': 'Explore',
      },
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  Widget _getBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return const WatchlistScreen();
      case 1:
        return const TradesScreen();
      case 2:
        return const DashboardScreen();
      case 3:
        return const FundsScreen();
      case 4:
        return Center(
          child: CustomTextWidget(
            'Explore Screen',
            Theme.of(context).textTheme.displayMedium!,
          ),
        );
      default:
        return const WatchlistScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Theme.of(context).primaryTextTheme.labelLarge!.color,
          size: 30,
        ),
        title: CustomTextWidget(
          'Demo Screen',
          Theme.of(context).textTheme.headlineMedium!,
        ),
      ),
      body: _menuItems != null
          ? _getBodyContent()
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _menuItems != null
          ? _buildBottomNavigationBar(isLight)
          : null,
    );
  }

  Widget _buildBottomNavigationBar(bool isLight) {
    if (_menuItems == null) return const SizedBox.shrink();
    
    final List<Widget> items = List<Widget>.generate(
      _menuItems!.length,
      (int index) {
        return _buildTabItem(
          item: _menuItems![index],
          index: index,
          onPressed: _onTabTapped,
          isLight: isLight,
        );
      },
    );
    
    return SizedBox(
      child: BottomAppBar(
        color: isLight
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: items,
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required Map<String, dynamic> item,
    required int index,
    required Function onPressed,
    required bool isLight,
  }) {
    final isSelected = _selectedIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(index),
        child: SizedBox(
          height: 65.w,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 26.w,
                  height: 26.w,
                  child: isSelected ? item['activeIcon'] : item['icon'],
                ),
                Text(
                  item['title'],
                  key: Key('BOTTOM_NAVIGATION_MENU_$index'),
                  style: isSelected
                      ? Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                          color: AppColors.positiveColor(isLight),
                        )
                      : Theme.of(context).primaryTextTheme.bodySmall!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

