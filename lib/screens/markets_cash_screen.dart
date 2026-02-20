import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/toggle_circular_widget.dart';
import '../widgets/info_bottomsheet.dart';
import '../models/symbols_model.dart';
import 'watchlist_list_widget.dart';

class MarketsCashScreen extends StatefulWidget {
  final TabController tabControllerCash;
  const MarketsCashScreen({Key? key, required this.tabControllerCash})
      : super(key: key);

  @override
  State<MarketsCashScreen> createState() => _MarketsCashScreenState();
}

class _MarketsCashScreenState extends State<MarketsCashScreen> {
  int _selectedExchangeIndex = 0; // 0 = NSE, 1 = BSE
  int _selectedIndexFilter = 1; // Default to Nifty 50
  final List<String> _marketMoversTabs = [
    'Top Gainers',
    'Top Losers',
    '52W High',
    '52W Low',
    'Most Active',
  ];

  // Dummy indices list for NSE
  final List<String> _nseIndices = [
    'ALL',
    'NIFTY 50',
    'NIFTY 100',
    'BANKNIFTY',
    'NIFTY IT',
    'NIFTY MIDCAP 100',
  ];

  // Dummy indices list for BSE
  final List<String> _bseIndices = [
    'ALL',
    'SENSEX',
    'BSE 100',
    'BSE 200',
  ];

  // Dummy indices data
  final List<Map<String, String>> _indicesList = [
    {
      'name': 'NIFTY 50',
      'value': '24,567.89',
      'change': '+125.50',
      'changePercent': '+0.51',
    },
    {
      'name': 'SENSEX',
      'value': '80,123.45',
      'change': '+350.20',
      'changePercent': '+0.44',
    },
    {
      'name': 'NIFTY BANK',
      'value': '52,345.67',
      'change': '+89.30',
      'changePercent': '+0.17',
    },
    {
      'name': 'NIFTY IT',
      'value': '35,678.90',
      'change': '-45.60',
      'changePercent': '-0.13',
    },
  ];

  // Dummy market movers data
  final List<Symbols> _gainersList = [
    Symbols(
      dispSym: 'TATAMOTORS',
      companyName: 'Tata Motors Ltd',
      ltp: '850.50',
      chng: '+45.20',
      chngPer: '+5.61',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'ADANIPORTS',
      companyName: 'Adani Ports and SEZ',
      ltp: '1,245.00',
      chng: '+38.50',
      chngPer: '+3.19',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'BAJFINANCE',
      companyName: 'Bajaj Finance Ltd',
      ltp: '7,890.00',
      chng: '+125.00',
      chngPer: '+1.61',
      exc: 'NSE',
    ),
  ];

  final List<Symbols> _losersList = [
    Symbols(
      dispSym: 'WIPRO',
      companyName: 'Wipro Ltd',
      ltp: '450.25',
      chng: '-15.75',
      chngPer: '-3.38',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'TECHM',
      companyName: 'Tech Mahindra Ltd',
      ltp: '1,234.50',
      chng: '-28.50',
      chngPer: '-2.26',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'INFY',
      companyName: 'Infosys Ltd',
      ltp: '1,567.80',
      chng: '-22.20',
      chngPer: '-1.40',
      exc: 'NSE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(), // Stops scrolling at the end
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            // Market Indices Section
            _buildHeaderWidget('Market Indices'),
            _buildIndicesList(),
            _buildViewMoreWidget('View More'),
            
            // Market News Section
            _buildMarketNewsSection(),
            
            // Market Movers Section
            _buildMarketMoversHeader(),
            SizedBox(height: AppWidgetSize.dimen_5),
            _buildMarketMoversTabs(),
          ],
        ),
      );
  }

  Widget _buildHeaderWidget(String title, {Widget? actionBtn}) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppWidgetSize.dimen_20,
        top: AppWidgetSize.dimen_8,
        right: AppWidgetSize.dimen_20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            title,
            Theme.of(context).primaryTextTheme.titleSmall,
          ),
          if (actionBtn != null) actionBtn,
        ],
      ),
    );
  }

  Widget _buildViewMoreWidget(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: TextButton(
          onPressed: () {
            // Navigate to view more
          },
          child: CustomTextWidget(
            title,
            Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.headline5Size,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicesList() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_15,
        left: AppWidgetSize.dimen_20,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(
          left: AppWidgetSize.dimen_5,
          bottom: AppWidgetSize.dimen_5,
        ),
        height: 98.w,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _indicesList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildIndexCard(_indicesList[index]);
          },
        ),
      ),
    );
  }

  Widget _buildIndexCard(Map<String, String> indexData) {
    final isPositive = indexData['change']!.startsWith('+');
    final isLight = Theme.of(context).brightness == Brightness.light;
    final changeColor = isPositive
        ? AppColors.positiveColor(isLight)
        : AppColors.negativeColor;

    return Padding(
      padding: EdgeInsets.only(right: AppWidgetSize.dimen_10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: indexData['name']!.length > 15 ? 200.w : 155.w,
          maxWidth: 200.w,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidgetSize.dimen_5,
            vertical: 5.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              width: 0.5.w,
              color: Theme.of(context).dividerColor,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).dividerColor,
                blurRadius: 2.5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 8.w,
                  left: 12.w,
                  right: 12.w,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: CustomTextWidget(
                    indexData['name']!,
                    Theme.of(context)
                        .primaryTextTheme
                        .labelSmall!
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.w,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 4.w,
                  left: 12.w,
                  right: 12.w,
                  bottom: 8.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      indexData['value']!,
                      Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w,
                            color: changeColor,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    CustomTextWidget(
                      '${indexData['change']!} (${indexData['changePercent']!}%)',
                      Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle
                                ?.color ??
                                Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 12.w,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketNewsSection() {
    final List<Map<String, String>> newsItems = [
      {
        'date': '2 hours ago',
        'headline': 'Stock markets hit new highs as investors remain bullish',
      },
      {
        'date': '4 hours ago',
        'headline': 'Tech stocks surge on strong earnings reports',
      },
      {
        'date': '6 hours ago',
        'headline': 'Banking sector shows resilience amid economic challenges',
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Market News',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 10.w, bottom: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                newsItems.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: _buildNewsCard(newsItems[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(Map<String, String> newsItem) {
    return GestureDetector(
      onTap: () {
        // Navigate to news detail
      },
      child: Container(
        height: 110.w,
        width: 280.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(
            width: 1.w,
            color: Theme.of(context).dividerColor,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color(0x00d6e56e).withOpacity(0.08),
            ],
          ),
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Navigate to news detail
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        newsItem['date']!,
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 12.w,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle
                                  ?.color ??
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                        textAlign: TextAlign.start,
                      ),
                      CustomTextWidget(
                        newsItem['headline']!,
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: AppWidgetSize.fontSize14,
                              fontWeight: FontWeight.w400,
                            ),
                        padding: EdgeInsets.symmetric(vertical: 6.w),
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  size: 16.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketMoversHeader() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppWidgetSize.dimen_20,
        right: AppWidgetSize.dimen_20,
        top: 4.w,
      ),
      child: Row(
        children: [
          CustomTextWidget(
            'Market Movers',
            Theme.of(context).primaryTextTheme.titleSmall,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppWidgetSize.dimen_4,
              left: AppWidgetSize.dimen_5,
            ),
            child: GestureDetector(
              onTap: () {
                // Show info bottom sheet
              },
              child: AppImages.infoIcon(
                context,
                color: Theme.of(context).primaryIconTheme.color,
                isColor: true,
                width: AppWidgetSize.dimen_22,
                height: AppWidgetSize.dimen_22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketMoversTabs() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TabBar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: widget.tabControllerCash,
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 15.w, left: 8.w),
            indicatorPadding: EdgeInsets.only(right: 3.w, left: 0.w),
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: AppWidgetSize.dimen_2,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: Theme.of(context).primaryTextTheme.headlineMedium,
            labelColor: Theme.of(context).primaryTextTheme.headlineMedium!.color,
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            unselectedLabelColor: Theme.of(context).textTheme.labelLarge!.color,
            tabs: _marketMoversTabs
                .map((String item) => Tab(child: Text(item)))
                .toList(),
          ),
        ),
        // NSE/BSE Toggle and Dropdown - just above the table
        _buildSegmentDropdownView(),
        // Market Movers Table - Calculate height based on content
        SizedBox(
          height: _calculateTableHeight(),
          child: TabBarView(
            controller: widget.tabControllerCash,
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling here, parent handles it
            children: [
              _buildMarketMoversList(_gainersList),
              _buildMarketMoversList(_losersList),
              _buildMarketMoversList(_gainersList), // 52W High
              _buildMarketMoversList(_losersList), // 52W Low
              _buildMarketMoversList(_gainersList), // Most Active
            ],
          ),
        ),
      ],
    );
  }

  // Calculate table height based on the longest list
  double _calculateTableHeight() {
    final maxLength = [
      _gainersList.length,
      _losersList.length,
    ].reduce((a, b) => a > b ? a : b);
    // Each row is approximately 80.w in height, add some padding
    return (maxLength * 80.w) + 20.w;
  }

  Widget _buildMarketMoversList(List<Symbols> symbolsList) {
    return WatchlistListWidget(
      symbolList: symbolsList,
      scrollController: ScrollController(),
      isFromWatchlistScreen: false, // Use shrinkWrap for nested scroll
    );
  }

  Widget _buildSegmentDropdownView() {
    return Container(
      padding: EdgeInsets.only(
        left: 22.w,
        right: AppWidgetSize.dimen_16,
        top: 10.w,
        bottom: 10.w,
      ),
      width: AppWidgetSize.screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFutureOptionsSegmentContent(),
          _buildMarketMoversIndicesWidget(
            _selectedExchangeIndex == 0
                ? _nseIndices[_selectedIndexFilter]
                : _bseIndices[_selectedIndexFilter],
          ),
        ],
      ),
    );
  }

  Widget _buildFutureOptionsSegmentContent() {
    return Container(
      height: AppWidgetSize.dimen_40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppWidgetSize.dimen_2),
        child: ToggleCircularWidget(
          key: const Key('marketsToggleWidget'),
          height: AppWidgetSize.dimen_40,
          minWidth: AppWidgetSize.dimen_80,
          cornerRadius: AppWidgetSize.dimen_20,
          activeBgColor:
              Theme.of(context).primaryTextTheme.displayLarge?.color ??
              Theme.of(context).textTheme.displayLarge?.color ??
              Colors.black,
          activeTextColor: Theme.of(context).colorScheme.secondary,
          inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
          inactiveTextColor:
              Theme.of(context).primaryTextTheme.displayLarge?.color ??
              Theme.of(context).textTheme.displayLarge?.color ??
              Colors.black,
          labels: const ['NSE', 'BSE'],
          initialLabel: _selectedExchangeIndex,
          activeTextStyle: (Theme.of(context)
                  .primaryTextTheme
                  .headlineSmall ??
              Theme.of(context).textTheme.headlineSmall ??
              const TextStyle())
              .copyWith(fontSize: AppWidgetSize.fontSize12),
          inactiveTextStyle:
              Theme.of(context).inputDecorationTheme.labelStyle ??
              Theme.of(context).textTheme.labelLarge ??
              Theme.of(context).textTheme.bodyMedium!,
          onToggle: (int selectedTabValue) {
            setState(() {
              _selectedExchangeIndex = selectedTabValue;
              _selectedIndexFilter = 1; // Reset to first index when switching
            });
          },
        ),
      ),
    );
  }

  Widget _buildMarketMoversIndicesWidget(String title) {
    return GestureDetector(
      onTap: () {
        _showIndicesBottomSheet();
      },
      child: Container(
        width: AppWidgetSize.screenWidth(context) / 2.5,
        height: AppWidgetSize.dimen_40,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                    child: CustomTextWidget(
                      title,
                      Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: AppWidgetSize.fontSize14,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: AppWidgetSize.dimen_5),
              child: GestureDetector(
                onTap: () {
                  _showIndicesBottomSheet();
                },
                child: AppImages.downArrow(
                  context,
                  isColor: true,
                  color: Theme.of(context).primaryIconTheme.color,
                  width: AppWidgetSize.dimen_25,
                  height: AppWidgetSize.dimen_25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIndicesBottomSheet() {
    final indicesList = _selectedExchangeIndex == 0 ? _nseIndices : _bseIndices;
    
    InfoBottomSheet.showInfoBottomsheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  'Choose Index',
                  Theme.of(context).textTheme.displayMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppImages.closeIcon(
                    context,
                    width: AppWidgetSize.dimen_25,
                    height: AppWidgetSize.dimen_25,
                    color: Theme.of(context).primaryIconTheme.color,
                    isColor: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: AppWidgetSize.dimen_1),
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: false,
              itemCount: indicesList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final isSelected = index == _selectedIndexFilter;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndexFilter = index;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: AppWidgetSize.dimen_10,
                            bottom: AppWidgetSize.dimen_10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: AppWidgetSize.dimen_10),
                                    child: CustomTextWidget(
                                      indicesList[index],
                                      Theme.of(context).primaryTextTheme.labelLarge!
                                          .copyWith(fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              if (isSelected)
                                SizedBox(
                                  child: AppImages.greenTickIcon(
                                    context,
                                    width: AppWidgetSize.dimen_22,
                                    height: AppWidgetSize.dimen_22,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Divider(
                        thickness: AppWidgetSize.dimen_1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      context,
      height: MediaQuery.of(context).size.height * 0.5,
    );
  }

  Widget _buildAllScannersButton() {
    return TextButton(
      onPressed: () {
        // Navigate to all scanners
      },
      child: CustomTextWidget(
        'All Scanners',
        Theme.of(context).primaryTextTheme.headlineMedium!,
      ),
    );
  }

  Widget _buildScannersPlaceholder() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppWidgetSize.dimen_20,
        right: AppWidgetSize.dimen_20,
        top: AppWidgetSize.dimen_16,
        bottom: AppWidgetSize.dimen_35,
      ),
      child: Row(
        children: [
          _buildScannerBox(
            'Breakout\nBullish',
            '12',
            Theme.of(context).primaryColor,
          ),
          SizedBox(width: AppWidgetSize.dimen_8),
          Expanded(
            child: Column(
              children: [
                _buildScannerBox(
                  'RSI - Bullish',
                  '8',
                  Theme.of(context).primaryColor,
                ),
                SizedBox(height: AppWidgetSize.dimen_8),
                _buildScannerBox(
                  'MACD - Bullish',
                  '15',
                  Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerBox(String title, String count, Color color) {
    return Container(
      padding: EdgeInsets.all(AppWidgetSize.dimen_15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          width: 0.5.w,
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            title,
            Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: AppWidgetSize.dimen_5),
          CustomTextWidget(
            count,
            Theme.of(context).primaryTextTheme.headlineLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFIIDIIPlaceholder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_20),
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFIIDIIToggle('FII', true),
              _buildFIIDIIToggle('DII', false),
              _buildDayToggle('Today'),
            ],
          ),
          SizedBox(height: AppWidgetSize.dimen_15),
          _buildFIIDIIData(),
        ],
      ),
    );
  }

  Widget _buildFIIDIIToggle(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Toggle selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_15,
          vertical: AppWidgetSize.dimen_8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            width: 1.w,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: CustomTextWidget(
          label,
          Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildDayToggle(String label) {
    return GestureDetector(
      onTap: () {
        // Toggle day
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_15,
          vertical: AppWidgetSize.dimen_8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            width: 1.w,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: CustomTextWidget(
          label,
          Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildFIIDIIData() {
    return Container(
      padding: EdgeInsets.all(AppWidgetSize.dimen_15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          width: 0.5.w,
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        children: [
          _buildFIIDIIRow('Equity', '₹1,234.56 Cr', '+123.45'),
          Divider(height: 1.w, color: Theme.of(context).dividerColor),
          _buildFIIDIIRow('Debt', '₹567.89 Cr', '-45.67'),
          Divider(height: 1.w, color: Theme.of(context).dividerColor),
          _buildFIIDIIRow('Hybrid', '₹234.12 Cr', '+12.34'),
        ],
      ),
    );
  }

  Widget _buildFIIDIIRow(String category, String value, String change) {
    final isPositive = change.startsWith('+');
    final isLight = Theme.of(context).brightness == Brightness.light;
    final changeColor = isPositive
        ? AppColors.positiveColor(isLight)
        : AppColors.negativeColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            category,
            Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            children: [
              CustomTextWidget(
                value,
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(width: AppWidgetSize.dimen_15),
              CustomTextWidget(
                change,
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealsPlaceholder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_20),
      padding: EdgeInsets.only(top: 10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildDealsToggle('Block', true),
              SizedBox(width: AppWidgetSize.dimen_10),
              _buildDealsToggle('Bulk', false),
            ],
          ),
          SizedBox(height: AppWidgetSize.dimen_10),
          _buildDealsList(),
          Padding(
            padding: EdgeInsets.only(bottom: 10.w),
            child: _buildViewMoreWidget('View More'),
          ),
        ],
      ),
    );
  }

  Widget _buildDealsToggle(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Toggle selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_15,
          vertical: AppWidgetSize.dimen_8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            width: 1.w,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: CustomTextWidget(
          label,
          Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildDealsList() {
    final List<Map<String, String>> deals = [
      {
        'symbol': 'RELIANCE',
        'price': '2,450.00',
        'quantity': '1,25,000',
        'value': '30.63 Cr',
      },
      {
        'symbol': 'TCS',
        'price': '3,567.50',
        'quantity': '50,000',
        'value': '17.84 Cr',
      },
      {
        'symbol': 'HDFCBANK',
        'price': '1,789.25',
        'quantity': '75,000',
        'value': '13.42 Cr',
      },
    ];

    return Container(
      padding: EdgeInsets.all(AppWidgetSize.dimen_15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          width: 0.5.w,
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        children: List.generate(
          deals.length,
          (index) => Column(
            children: [
              _buildDealRow(deals[index]),
              if (index < deals.length - 1)
                Divider(
                  height: 1.w,
                  color: Theme.of(context).dividerColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDealRow(Map<String, String> deal) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                deal['symbol']!,
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: AppWidgetSize.dimen_5),
              CustomTextWidget(
                'Qty: ${deal['quantity']}',
                Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextWidget(
                '₹${deal['price']}',
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: AppWidgetSize.dimen_5),
              CustomTextWidget(
                'Value: ₹${deal['value']}',
                Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

