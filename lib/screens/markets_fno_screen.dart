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

class MarketsFNOScreen extends StatefulWidget {
  final TabController tabControllerFno;
  const MarketsFNOScreen({Key? key, required this.tabControllerFno})
      : super(key: key);

  @override
  State<MarketsFNOScreen> createState() => _MarketsFNOScreenState();
}

class _MarketsFNOScreenState extends State<MarketsFNOScreen> {
  int _selectedToggleIndex = 0; // 0 = Future, 1 = Options
  int _selectedExchangeIndex = 0; // 0 = NSE, 1 = BSE
  int _selectedIndexFilter = 1; // Default to Nifty 50

  final List<String> _marketMoversTabs = [
    'Top Gainers',
    'Top Losers',
    'Most Active Value',
    'OI Gainers',
    'OI Losers',
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

  // Dummy expiry dates for Options
  final List<String> _expiryDates = [
    '25-Jul-2024',
    '01-Aug-2024',
    '08-Aug-2024',
    '15-Aug-2024',
  ];
  String _selectedExpiryDate = '25-Jul-2024';

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

  // Dummy data
  final List<Symbols> _gainersList = [
    Symbols(
      dispSym: 'NIFTY',
      companyName: 'Nifty 50',
      ltp: '24,567.80',
      chng: '+125.50',
      chngPer: '+0.51',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'BANKNIFTY',
      companyName: 'Bank Nifty',
      ltp: '52,123.40',
      chng: '+234.20',
      chngPer: '+0.45',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'FINNIFTY',
      companyName: 'Fin Nifty',
      ltp: '21,456.30',
      chng: '+98.70',
      chngPer: '+0.46',
      exc: 'NSE',
    ),
  ];

  final List<Symbols> _losersList = [
    Symbols(
      dispSym: 'NIFTY',
      companyName: 'Nifty 50',
      ltp: '24,442.30',
      chng: '-125.50',
      chngPer: '-0.51',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'BANKNIFTY',
      companyName: 'Bank Nifty',
      ltp: '51,889.20',
      chng: '-234.20',
      chngPer: '-0.45',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'FINNIFTY',
      companyName: 'Fin Nifty',
      ltp: '21,357.60',
      chng: '-98.70',
      chngPer: '-0.46',
      exc: 'NSE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Market Indices Section
          _buildHeaderWidget('Market Indices'),
          _buildIndicesList(),
          _buildViewMoreWidget('View More'),
          
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

  Widget _buildMarketMoversHeader() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppWidgetSize.dimen_20,
        right: AppWidgetSize.dimen_15,
        top: 4.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          // Future/Options Toggle on extreme right
          Padding(
            padding: EdgeInsets.only(
              top: AppWidgetSize.dimen_8,
              right: AppWidgetSize.dimen_15,
            ),
            child: Container(
              height: AppWidgetSize.dimen_24,
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
                  key: const Key('fnoHeaderToggleWidget'),
                  height: AppWidgetSize.dimen_20,
                  minWidth: AppWidgetSize.dimen_40,
                  cornerRadius: AppWidgetSize.dimen_10,
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
                  labels: const ['Future', 'Options'],
                  initialLabel: _selectedToggleIndex,
                  activeTextStyle: (Theme.of(context)
                          .primaryTextTheme
                          .headlineSmall ??
                      Theme.of(context).textTheme.headlineSmall ??
                      const TextStyle())
                      .copyWith(fontSize: AppWidgetSize.fontSize12),
                  inactiveTextStyle: (Theme.of(context)
                          .inputDecorationTheme
                          .labelStyle ??
                      Theme.of(context).textTheme.labelLarge ??
                      Theme.of(context).textTheme.bodyMedium!)
                      .copyWith(fontSize: AppWidgetSize.fontSize12),
                  onToggle: (int selectedTabValue) {
                    setState(() {
                      _selectedToggleIndex = selectedTabValue;
                    });
                  },
                ),
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
        // Future/Options Toggle (only show when Options is selected)
        if (_selectedToggleIndex == 1) _buildExpiryFilterWidget(),
        // TabBar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).inputDecorationTheme.fillColor ??
                    Colors.grey.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: widget.tabControllerFno,
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 12.w, left: 12.w),
            indicatorPadding: EdgeInsets.only(right: 0.w, left: 0.w),
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
        // Market Movers Table
        SizedBox(
          height: _calculateTableHeight(),
          child: TabBarView(
            controller: widget.tabControllerFno,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMarketMoversList(_gainersList),
              _buildMarketMoversList(_losersList),
              _buildMarketMoversList(_gainersList), // Most Active Value
              _buildMarketMoversList(_gainersList), // OI Gainers
              _buildMarketMoversList(_losersList), // OI Losers
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryFilterWidget() {
    return Padding(
      padding: EdgeInsets.only(
        right: AppWidgetSize.dimen_5,
        left: AppWidgetSize.dimen_15,
        bottom: AppWidgetSize.dimen_5,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _expiryDates.map((expiry) {
            final isSelected = expiry == _selectedExpiryDate;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedExpiryDate = expiry;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.w,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.w),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: CustomTextWidget(
                  expiry,
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: AppWidgetSize.fontSize12,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  double _calculateTableHeight() {
    final maxLength = [
      _gainersList.length,
      _losersList.length,
    ].reduce((a, b) => a > b ? a : b);
    return (maxLength * 80.w) + 20.w;
  }

  Widget _buildMarketMoversList(List<Symbols> symbolsList) {
    return WatchlistListWidget(
      symbolList: symbolsList,
      scrollController: ScrollController(),
      isFromWatchlistScreen: false,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
          key: const Key('fnoToggleWidget'),
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
          labels: const ['Future', 'Options'],
          initialLabel: _selectedToggleIndex,
          activeTextStyle: (Theme.of(context)
                  .primaryTextTheme
                  .headlineSmall ??
              Theme.of(context).textTheme.headlineSmall ??
              const TextStyle())
              .copyWith(fontSize: AppWidgetSize.fontSize12),
          inactiveTextStyle: (Theme.of(context)
                  .inputDecorationTheme
                  .labelStyle ??
              Theme.of(context).textTheme.labelLarge ??
              Theme.of(context).textTheme.bodyMedium!)
              .copyWith(fontSize: AppWidgetSize.fontSize12),
          onToggle: (int selectedTabValue) {
            setState(() {
              _selectedToggleIndex = selectedTabValue;
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
                                    padding:
                                        EdgeInsets.only(left: AppWidgetSize.dimen_10),
                                    child: CustomTextWidget(
                                      indicesList[index],
                                      Theme.of(context)
                                          .primaryTextTheme
                                          .labelLarge!
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
}

