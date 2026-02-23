import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_images.dart';
import '../utils/app_color.dart';
import 'watchlist_screen.dart';
import 'trades_screen.dart';
import 'dashboard_screen.dart';
import 'funds_screen.dart';
import 'explore_screen.dart';

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
        return const ExploreScreen();
      default:
        return const WatchlistScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Scaffold(
      appBar: null,
      body: _menuItems != null
          ? SafeArea(
              bottom: false,
              child: _getBodyContent(),
            )
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
    
    return BottomAppBar(
      color: isLight
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.zero,
      child: SafeArea(
        top: false,
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
    final tabItemHeight = (64.h).clamp(58.0, 74.0).toDouble();
    final iconSize = (24.w).clamp(20.0, 26.0).toDouble();
    
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(index),
        child: SizedBox(
          height: tabItemHeight,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: isSelected ? item['activeIcon'] : item['icon'],
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      item['title'],
                      key: Key('BOTTOM_NAVIGATION_MENU_$index'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: isSelected
                          ? Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                              color: AppColors.positiveColor(isLight),
                            )
                          : Theme.of(context).primaryTextTheme.bodySmall!,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

