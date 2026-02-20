import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/toggle_circular_tabs_widget.dart';
import 'orders_main_screen.dart';
import 'positions_screen.dart';
import 'holdings_screen.dart';
import 'research_reinvented_screen.dart';

class TradesScreen extends StatefulWidget {
  const TradesScreen({Key? key}) : super(key: key);

  @override
  State<TradesScreen> createState() => _TradesScreenState();
}

class _TradesScreenState extends State<TradesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedToggleIndex = 2; // Default to Holdings

  final List<String> _toggleList = [
    'My Orders',
    'Positions',
    'Holdings',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: _selectedToggleIndex,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedToggleIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              toolbarHeight: AppWidgetSize.dimen_66,
              title: SizedBox(
                height: 100.w,
                child: _buildTopAppBarContent(),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: AppWidgetSize.dimen_1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBarContent() {
    return Container(
      height: AppWidgetSize.fullWidth(context),
      padding: EdgeInsets.only(left: 10.w, right: 12.w),
      child: Row(
        children: [
          SizedBox(
            width: AppWidgetSize.screenWidth(context) * 0.62,
            child: ToggleCircularTabsWidget(
              tabController: _tabController,
              minWidth: AppWidgetSize.dimen_1,
              cornerRadius: AppWidgetSize.dimen_20,
              labels: _toggleList,
              initialLabel: _selectedToggleIndex,
              onToggle: (int selectedTabValue) {
                _selectedToggleIndex = selectedTabValue;
                _tabController.animateTo(_selectedToggleIndex);
              },
              fontSize: AppWidgetSize.dimen_14,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 8.w),
                _buildResearchIcon(),
                SizedBox(width: 8.w),
                _buildMarketIndicesIcon(),
                SizedBox(width: 12.w),
                _buildProfileIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchIcon() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ResearchReinventedScreen(),
          ),
        );
      },
      child: AppImages.researchLogo(
        context,
        width: 26.w,
        height: 26.w,
      ),
    );
  }

  Widget _buildMarketIndicesIcon() {
    return GestureDetector(
      onTap: () {
        // Handle market indices icon tap
      },
      child: AppImages.marketsPullDown(
        context,
        isColor: true,
        width: 25.w,
        height: 25.w,
      ),
    );
  }

  Widget _buildProfileIcon() {
    return GestureDetector(
      onTap: () {
        // Handle profile icon tap
      },
      child: Container(
        width: AppWidgetSize.dimen_32,
        height: AppWidgetSize.dimen_32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.positiveColor(
            Theme.of(context).brightness == Brightness.light,
          ),
        ),
        child: Center(
          child: CustomTextWidget(
            'HC',
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.w,
                ) ??
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.w,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        const OrdersMainScreen(),
        const PositionsScreen(),
        const HoldingsScreen(),
      ],
    );
  }
}

