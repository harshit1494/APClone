import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/toggle_circular_widget.dart';
import '../widgets/info_bottomsheet.dart';
import '../models/symbols_model.dart';
import 'watchlist_list_widget.dart';

class MarketsCurrencyScreen extends StatefulWidget {
  final TabController tabControllerCurrency;
  const MarketsCurrencyScreen({Key? key, required this.tabControllerCurrency})
      : super(key: key);

  @override
  State<MarketsCurrencyScreen> createState() => _MarketsCurrencyScreenState();
}

class _MarketsCurrencyScreenState extends State<MarketsCurrencyScreen> {
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
    '22-Aug-2024',
    '29-Aug-2024',
  ];
  String _selectedExpiryDate = '25-Jul-2024';

  // Dummy data
  final List<Symbols> _gainersList = [
    Symbols(
      dispSym: 'USDINR',
      companyName: 'USD/INR',
      ltp: '83.45',
      chng: '+0.25',
      chngPer: '+0.30',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'EURINR',
      companyName: 'EUR/INR',
      ltp: '90.12',
      chng: '+0.18',
      chngPer: '+0.20',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'GBPINR',
      companyName: 'GBP/INR',
      ltp: '105.67',
      chng: '+0.32',
      chngPer: '+0.30',
      exc: 'NSE',
    ),
  ];

  final List<Symbols> _losersList = [
    Symbols(
      dispSym: 'USDINR',
      companyName: 'USD/INR',
      ltp: '83.20',
      chng: '-0.25',
      chngPer: '-0.30',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'EURINR',
      companyName: 'EUR/INR',
      ltp: '89.94',
      chng: '-0.18',
      chngPer: '-0.20',
      exc: 'NSE',
    ),
    Symbols(
      dispSym: 'GBPINR',
      companyName: 'GBP/INR',
      ltp: '105.35',
      chng: '-0.32',
      chngPer: '-0.30',
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
          // Market Movers Section (NO Market Indices)
          _buildMarketMoversHeader(),
          SizedBox(height: AppWidgetSize.dimen_5),
          _buildMarketMoversTabs(),
        ],
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
            controller: widget.tabControllerCurrency,
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
            controller: widget.tabControllerCurrency,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFutureOptionsSegmentContent(),
          _buildDateDropdownWidget(),
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
          key: const Key('currencyToggleWidget'),
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

  Widget _buildDateDropdownWidget() {
    return GestureDetector(
      onTap: () {
        _showDateBottomSheet();
      },
      child: Container(
        width: AppWidgetSize.screenWidth(context) / 2.5,
        height: AppWidgetSize.dimen_40,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.w),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 9.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              _selectedExpiryDate.isEmpty ? 'Choose date' : _selectedExpiryDate,
              _selectedExpiryDate.isNotEmpty
                  ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w,
                      ) ??
                      Theme.of(context).textTheme.bodyLarge!
                  : Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary,
                      ) ??
                      Theme.of(context).textTheme.headlineSmall!,
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 25.w,
            ),
          ],
        ),
      ),
    );
  }

  void _showDateBottomSheet() {
    InfoBottomSheet.showInfoBottomsheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20.w,
              left: 30.w,
              right: 30.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  'Expiry Date',
                  Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: AppWidgetSize.fontSize28,
                      ) ??
                      Theme.of(context).textTheme.displayMedium!,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppImages.closeIcon(
                    context,
                    width: AppWidgetSize.dimen_22,
                    height: AppWidgetSize.dimen_22,
                    color: Theme.of(context).primaryIconTheme.color,
                    isColor: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              itemCount: _expiryDates.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (context, index) {
                final isSelected = _expiryDates[index] == _selectedExpiryDate;
                return ListTile(
                  horizontalTitleGap: 2,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  title: CustomTextWidget(
                    _expiryDates[index],
                    Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: AppWidgetSize.fontSize16,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!,
                  ),
                  trailing: isSelected
                      ? AppImages.greenTickIcon(
                          context,
                          width: AppWidgetSize.dimen_22,
                          height: AppWidgetSize.dimen_22,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedExpiryDate = _expiryDates[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
      context,
      height: MediaQuery.of(context).size.height / 2.5,
      horizontalMargin: false,
    );
  }
}

