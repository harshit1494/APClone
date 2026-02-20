import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import '../widgets/toggle_circular_tabs_widget.dart';
import '../widgets/custom_text_widget.dart';
import '../models/symbols_model.dart';
import 'watchlist_list_widget.dart';
import 'markets_screen.dart';
import 'scanners_screen.dart';
import '../utils/app_images.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollControllerForTopContent = ScrollController();
  late TabController tabController;
  
  List<String> toggleList = ['Watchlist', 'Markets', 'Scanners'];
  int selectedToggleIndex = 0;
  String selectedWatchlist = 'My Stocks';
  List<Symbols> symbolsList = [];
  int symbolsCount = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: toggleList.length,
      initialIndex: selectedToggleIndex,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        selectedToggleIndex = tabController.index;
      });
    });
    _loadDummyData();
  }

  void _loadDummyData() {
    // Dummy data - exact same structure as original
    symbolsList = [
      Symbols(
        dispSym: 'RELIANCE',
        companyName: 'Reliance Industries Ltd',
        ltp: '2,450.50',
        chng: '25.50',
        chngPer: '1.05',
        exc: 'NSE',
        qty: '10',
      ),
      Symbols(
        dispSym: 'TCS',
        companyName: 'Tata Consultancy Services Ltd',
        ltp: '3,245.75',
        chng: '-15.25',
        chngPer: '-0.47',
        exc: 'NSE',
      ),
      Symbols(
        dispSym: 'HDFCBANK',
        companyName: 'HDFC Bank Ltd',
        ltp: '1,650.00',
        chng: '12.50',
        chngPer: '0.76',
        exc: 'NSE',
        qty: '5',
      ),
      Symbols(
        dispSym: 'INFY',
        companyName: 'Infosys Ltd',
        ltp: '1,425.30',
        chng: '-8.20',
        chngPer: '-0.57',
        exc: 'NSE',
      ),
      Symbols(
        dispSym: 'ICICIBANK',
        companyName: 'ICICI Bank Ltd',
        ltp: '985.50',
        chng: '5.25',
        chngPer: '0.54',
        exc: 'NSE',
        qty: '15',
      ),
      Symbols(
        dispSym: 'HINDUNILVR',
        companyName: 'Hindustan Unilever Ltd',
        ltp: '2,680.00',
        chng: '18.00',
        chngPer: '0.68',
        exc: 'NSE',
      ),
      Symbols(
        dispSym: 'BHARTIARTL',
        companyName: 'Bharti Airtel Ltd',
        ltp: '1,125.75',
        chng: '-12.25',
        chngPer: '-1.08',
        exc: 'NSE',
        qty: '20',
      ),
      Symbols(
        dispSym: 'SBIN',
        companyName: 'State Bank of India',
        ltp: '625.50',
        chng: '8.50',
        chngPer: '1.38',
        exc: 'NSE',
      ),
    ];
    symbolsCount = symbolsList.length;
  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollControllerForTopContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return NestedScrollView(
      controller: _scrollControllerForTopContent,
      headerSliverBuilder: (BuildContext ctext, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctext),
            sliver: SliverAppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              expandedHeight: 66.w,
              pinned: true,
              centerTitle: false,
              floating: false,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Colors.transparent,
              toolbarHeight: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: GestureDetector(
                  onVerticalDragDown: (_) {},
                  behavior: HitTestBehavior.opaque,
                  child: _buildTopAppBarContent(),
                ),
              ),
            ),
          ),
        ];
      },
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
        child: returnToggleContent(),
      ),
    );
  }

  Widget _buildTopAppBarContent() {
    return Container(
      height: AppWidgetSize.fullWidth(context),
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: AppWidgetSize.screenWidth(context) * 0.62,
            child: ToggleCircularTabsWidget(
              tabController: tabController,
              key: const Key('watchlistToggleWidget'),
              minWidth: AppWidgetSize.dimen_1,
              cornerRadius: AppWidgetSize.dimen_20,
              labels: toggleList,
              initialLabel: selectedToggleIndex,
              onToggle: (int selectedTabValue) {
                selectedToggleIndex = selectedTabValue;
                tabController.animateTo(selectedToggleIndex);
              },
              fontSize: AppWidgetSize.dimen_14,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 8.w),
                // Research icon
                GestureDetector(
                  onTap: () {
                    // Navigate to research screen
                  },
                  child: AppImages.researchLogo(
                    context,
                    width: 26.w,
                    height: 26.w,
                  ),
                ),
                SizedBox(width: 8.w),
                // Market indices icon
                GestureDetector(
                  onTap: () {
                    // Show market indices bottom sheet
                  },
                  child: AppImages.marketsPullDown(
                    context,
                    isColor: true,
                    width: 25.w,
                    height: 25.w,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 12.w),
                // Profile icon with HC text
                Container(
                  width: AppWidgetSize.dimen_32,
                  height: AppWidgetSize.dimen_32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: CustomTextWidget(
                      'HC',
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: AppWidgetSize.fontSize14,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget returnToggleContent() {
    return TabBarView(
      controller: tabController,
      children: [
        _buildWatchlistContent(),
        _buildMarketsContent(),
        _buildScannersContent(),
      ],
    );
  }

  Widget _buildWatchlistContent() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBottomAppBarWidget(selectedWatchlist, symbolsCount),
          Expanded(
            child: WatchlistListWidget(
              symbolList: symbolsList,
              scrollController: ScrollController(),
              isFromWatchlistScreen: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketsContent() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: const MarketsScreen(),
    );
  }

  Widget _buildScannersContent() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: const ScannersScreen(),
    );
  }

  Widget _buildBottomAppBarWidget(String title, int watchlistSymCount) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return ClipRRect(
      child: Container(
        height: AppWidgetSize.dimen_70,
        margin: EdgeInsets.only(bottom: 3.w),
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 10.w,
          bottom: 10.w,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor,
              offset: const Offset(0.0, 1.0),
              blurRadius: AppWidgetSize.dimen_2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Show watchlist selector bottom sheet
                },
                child: Container(
                  height: AppWidgetSize.dimen_70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).snackBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(AppWidgetSize.dimen_12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Row(
                          children: [
                            // Globe icon for My Stocks (first in watchlistIcons)
                            AppImages.globeIcon(
                              context,
                              height: AppWidgetSize.fontSize22,
                              width: AppWidgetSize.fontSize22,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.w,
                                top: AppWidgetSize.dimen_2,
                              ),
                              child: CustomTextWidget(
                                title,
                                Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall!
                                    .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppWidgetSize.fontSize18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: AppWidgetSize.dimen_3,
                                top: AppWidgetSize.dimen_2,
                              ),
                              child: CustomTextWidget(
                                '($watchlistSymCount)',
                                Theme.of(context).primaryTextTheme.bodySmall!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            // Show watchlist selector bottom sheet
                          },
                          child: AppImages.viewWatchlistIcon(
                            context,
                            isColor: false,
                            width: AppWidgetSize.dimen_25,
                            height: AppWidgetSize.dimen_25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Filter icon
                InkWell(
                  onTap: () {
                    // Show filter bottom sheet
                  },
                  child: AppUtils().buildFilterIcon(
                    context,
                    isSelected: false,
                  ),
                ),
                SizedBox(width: 5.w),
                // Info icon
                GestureDetector(
                  onTap: () {
                    // Show info bottom sheet
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.w),
                    child: AppImages.infoIcon(
                      context,
                      width: AppWidgetSize.dimen_20,
                      height: AppWidgetSize.dimen_20,
                      color: Theme.of(context).primaryIconTheme.color,
                      isColor: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 3.w),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to search
                    },
                    child: AppImages.addFilledIcon(
                      context,
                      width: AppWidgetSize.dimen_25,
                      height: AppWidgetSize.dimen_25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

