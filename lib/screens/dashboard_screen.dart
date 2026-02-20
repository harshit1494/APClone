import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/rupee_symbol_widget.dart';
import '../widgets/label_border_text_widget.dart';
import '../widgets/circular_button_toggle_widget.dart';
import '../widgets/gradient_button_widget.dart';
import 'research_reinvented_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  int _unreadNotificationCount = 0;

  // Dummy data for Market Indices
  final List<Map<String, dynamic>> _marketIndices = [
    {
      'title': 'NIFTY 50',
      'ltp': '22123.50',
      'chng': '125.30',
      'chngPer': '0.57',
      'expiryDate': '2024-12-26', // Add expiry date
    },
    {
      'title': 'SENSEX',
      'ltp': '73045.80',
      'chng': '425.60',
      'chngPer': '0.59',
      'expiryDate': '2024-12-27', // Add expiry date
    },
    {
      'title': 'NIFTY BANK',
      'ltp': '48234.20',
      'chng': '-125.40',
      'chngPer': '-0.26',
      'expiryDate': '', // No expiry
    },
    {
      'title': 'NIFTY IT',
      'ltp': '32145.60',
      'chng': '234.50',
      'chngPer': '0.74',
      'expiryDate': '2024-12-28', // Add expiry date
    },
  ];

  // Dummy data for Holdings
  final String _holdingsCurrentValue = '125000.00';
  final String _holdingsOverallPL = '5000.75';
  final String _holdingsOverallPLPercent = '4.00';
  final String _holdingsInvested = '120000.00';
  final String _holdingsTodayPL = '2500.50';

  // Dummy data for Positions
  final String _positionsOverallPL = '2500.00';
  final String _positionsOverallPLPercent = '2.00';
  final String _positionsTodayPL = '1250.00';
  final String _positionsTodayPLPercent = '1.00';

  // Dummy data for Funds
  final String _availableForInvesting = '50000.00';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Column(
      children: [
        // Top AppBar Content
        Container(
          height: AppWidgetSize.dimen_66,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 100.w,
            child: _buildTopAppBarContent(),
          ),
        ),
        // Body Content
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market Indices Widget
                  _buildMarketIndicesWidget(),
                  // Products Widget
                  _buildProductsWidget(),
                  // Themes Widget
                  _buildThemesWidget(),
                  // Explore ETFs Widget
                  _buildExploreEtfsWidget(),
                  // Ongoing IPOs Widget
                  _buildOngoingIposWidget(),
                  // Advanced Trading Tools Widget
                  _buildAdvancedTradingToolsWidget(),
                  // Discover Widget
                  _buildDiscoverWidget(),
                  // Refer & Earn and Stock SIP Widget
                  _buildReferAndEarnWidget(),
                  // My Funds Widget
                  _buildMyFundsWidget(),
                  // Market News Widget
                  _buildMarketNewsWidget(),
                  // Recently Visited Widget
                  _buildRecentlyVisitedWidget(),
                  // Manage Dashboard Widget
                  _buildManageDashboardWidget(),
                  SizedBox(height: AppWidgetSize.dimen_20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopAppBarContent() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Container(
      height: AppWidgetSize.fullWidth(context),
      padding: EdgeInsets.only(left: 16.w, right: 19.w),
      child: Row(
        children: [
          // Arihant Logo (single logo, matching reference when no stories)
          isLight
              ? AppImages.arihantNewLogoLight(context, height: 23.w)
              : AppImages.arihantNewLogoDark(context, height: 23.w),
          SizedBox(width: 6.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Customize icon
                InkWell(
                  onTap: () {
                    // Handle customize tap
                  },
                  child: Icon(
                    Icons.tune,
                    size: 24.w,
                    color: isLight
                        ? const Color(0xFF434343)
                        : Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                // Research icon
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ResearchReinventedScreen(),
                      ),
                    );
                  },
                  child: AppImages.researchLogo(
                    context,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                SizedBox(width: 6.w),
                // Notification icon
                GestureDetector(
                  onTap: () {
                    // Handle notification tap
                  },
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 27.w,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      if (_unreadNotificationCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12.w,
                              minHeight: 12.w,
                            ),
                            child: Text(
                              _unreadNotificationCount > 9 ? '9+' : '$_unreadNotificationCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.w,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // Profile icon
                GestureDetector(
                  onTap: () {
                    // Handle profile tap
                  },
                  child: Container(
                    width: AppWidgetSize.dimen_32,
                    height: AppWidgetSize.dimen_32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.positiveColor(isLight),
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
                ),
                SizedBox(width: 4.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndicesWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_24,
        left: AppWidgetSize.dimen_12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(
              left: AppWidgetSize.dimen_5,
              bottom: AppWidgetSize.dimen_5,
            ),
            height: 115.w,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _marketIndices.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == _marketIndices.length) {
                  return _buildViewAllIndices();
                }
                return _buildMarketIndexCard(_marketIndices[index]);
              },
            ),
          ),
          _buildViewMoreWidget('View More'),
        ],
      ),
    );
  }

  Widget _buildMarketIndexCard(Map<String, dynamic> indexData) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final chng = double.tryParse(indexData['chng'] as String) ?? 0;
    final chngColor = chng >= 0
        ? AppColors.positiveColor(isLight)
        : AppColors.negativeColor;
    final expiryDate = indexData['expiryDate'] as String? ?? '';
    final hasExpiry = expiryDate.isNotEmpty;
    
    return GestureDetector(
      onTap: () {
        // Handle index tap
      },
      child: Padding(
        padding: EdgeInsets.only(right: AppWidgetSize.dimen_14),
        child: Container(
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
          width: 175.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title (left side)
                      Expanded(
                        child: Container(
                          height: 30.w,
                          padding: EdgeInsets.only(
                            top: 8.w,
                            left: 12.w,
                            right: hasExpiry ? 4.w : 12.w,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: CustomTextWidget(
                              indexData['title'] as String,
                              Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.w,
                                  ) ?? TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.w,
                                  ),
                              textAlign: TextAlign.left,
                              maxLines: null,
                            ),
                          ),
                        ),
                      ),
                      // Expiry tag (right side)
                      if (hasExpiry)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.w,
                          ),
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFF1),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomTextWidget(
                              _getExpiryTag(expiryDate),
                              Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.w,
                                    color: const Color(0xff7F7F88),
                                  ) ?? TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.w,
                                    color: const Color(0xff7F7F88),
                                  ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.w, left: 12.w, right: 12.w),
                    child: CustomTextWidget(
                      indexData['ltp'] as String,
                      Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.w,
                            color: chngColor,
                          ) ?? TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.w,
                            color: chngColor,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.w, left: 12.w, right: 12.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextWidget(
                          '${chng >= 0 ? '+' : ''}${indexData['chng']}',
                          Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                                fontSize: 12.w,
                                color: chngColor,
                              ) ?? TextStyle(
                                fontSize: 12.w,
                                color: chngColor,
                              ),
                        ),
                        SizedBox(width: 4.w),
                        CustomTextWidget(
                          '(${indexData['chngPer']}%)',
                          Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                                fontSize: 12.w,
                                color: chngColor,
                              ) ?? TextStyle(
                                fontSize: 12.w,
                                color: chngColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Bottom section with Option Chain | Futures Contract
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.w),
                    bottomRight: Radius.circular(10.w),
                  ),
                  color: !isLight
                      ? Theme.of(context).colorScheme.surface
                      : const Color(0xFFEBF7ED).withOpacity(0.8),
                ),
                height: 30.w,
                width: 175.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle option chain tap
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w, right: 5.w),
                        child: SizedBox(
                          height: 30.w,
                          child: Center(
                            child: CustomTextWidget(
                              'Option Chain',
                              Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor(isLight),
                                    fontSize: 11.w,
                                  ) ?? TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor(isLight),
                                    fontSize: 11.w,
                                  ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomTextWidget(
                      '|',
                      Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.w,
                            color: AppColors.primaryColor(isLight),
                          ) ?? TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.w,
                            color: AppColors.primaryColor(isLight),
                          ),
                      textAlign: TextAlign.end,
                    ),
                    InkWell(
                      onTap: () {
                        // Handle futures contract tap
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w, left: 5.w),
                        child: SizedBox(
                          height: 30.w,
                          child: Center(
                            child: CustomTextWidget(
                              'Futures Contract',
                              Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.w,
                                    color: AppColors.primaryColor(isLight),
                                  ) ?? TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.w,
                                    color: AppColors.primaryColor(isLight),
                                  ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
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

  String _getExpiryTag(String expiryDateStr) {
    try {
      DateTime expiryDate = DateTime.parse(expiryDateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final expiry = DateTime(expiryDate.year, expiryDate.month, expiryDate.day);

      final startOfWeek = today.subtract(
        Duration(days: today.weekday - 1),
      ); // Monday
      final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday
      final tomorrow = today.add(const Duration(days: 1));

      if (expiry == today) return 'Expiry Today';
      if (expiry == tomorrow) return 'Expiry Tom';

      if (expiry.isAfter(today) &&
          expiry.isBefore(endOfWeek.add(const Duration(days: 1)))) {
        // Show weekday name like Thu, Fri, etc.
        String weekday = _getWeekdayAbbreviation(expiry.weekday);
        return 'Expiry $weekday';
      }

      // Else: Next week or future → return "Expiry 29 May"
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return 'Expiry ${expiry.day} ${months[expiry.month - 1]}';
    } catch (e) {
      return '';
    }
  }

  String _getWeekdayAbbreviation(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  Widget _buildViewAllIndices() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return GestureDetector(
      onTap: () {
        // Handle view all indices
      },
      child: Padding(
        padding: EdgeInsets.only(right: AppWidgetSize.dimen_14),
        child: Container(
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
          child: InkWell(
            onTap: () {
              // Handle view all indices
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                  'View all indices',
                  Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.w,
                        color: AppColors.primaryColor(isLight),
                      ) ?? TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.w,
                        color: AppColors.primaryColor(isLight),
                      ),
                  padding: EdgeInsets.only(left: 24.w, right: 24.w),
                ),
                CustomTextWidget(
                  '(Indian & Global)',
                  Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle?.color,
                      ) ?? TextStyle(),
                  padding: EdgeInsets.only(top: 6.w, left: 24.w, right: 24.w),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewMoreWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 5.w, bottom: 8.w),
      child: GestureDetector(
        onTap: () {
          // Handle view more
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextWidget(
                title,
                Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                      fontSize: AppWidgetSize.fontSize16,
                    ) ?? TextStyle(fontSize: AppWidgetSize.fontSize16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyPortfolioWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppWidgetSize.dimen_16,
              right: AppWidgetSize.dimen_16,
            ),
            child: CustomTextWidget(
              'My Portfolio',
              Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: AppWidgetSize.fontSize22,
                  ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildHoldingsCard(),
                _buildPositionsCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingsCard() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final overallPLColor = _getProfitLossColor(_holdingsOverallPL);
    
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          width: 1.w,
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 1,
          ),
        ],
      ),
      width: 280.w,
      height: 150.w,
      child: InkWell(
        onTap: () {
          // Navigate to holdings
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 81.w,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, top: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 4,
                          ),
                          margin: EdgeInsets.only(bottom: 6.w),
                          child: CustomTextWidget(
                            'Holdings',
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 9.w,
                                ) ?? TextStyle(fontSize: 9.w),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '₹',
                              style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Arial',
                              ),
                            ),
                            SizedBox(width: 2.w),
                            CustomTextWidget(
                              _holdingsCurrentValue,
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w500,
                                  ) ?? TextStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.w),
                        Row(
                          children: [
                            CustomTextWidget(
                              'Overall P&L: ',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle?.color,
                                  ) ?? TextStyle(fontSize: 14.w),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '₹',
                                  style: TextStyle(
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w500,
                                    color: overallPLColor,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                CustomTextWidget(
                                  _holdingsOverallPL,
                                  Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: overallPLColor,
                                      ) ?? TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: overallPLColor,
                                      ),
                                ),
                              ],
                            ),
                            CustomTextWidget(
                              ' ($_holdingsOverallPLPercent%)',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle?.color,
                                  ) ?? TextStyle(fontSize: 14.w),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        size: 16.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildInvestBox(_holdingsInvested, 'Invested'),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildInvestBox(_holdingsTodayPL, 'Today\'s P&L'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionsCard() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final overallPLColor = _getProfitLossColor(_positionsOverallPL);
    
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 16.w, right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          width: 1.w,
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 1,
          ),
        ],
      ),
      width: 280.w,
      height: 150.w,
      child: InkWell(
        onTap: () {
          // Navigate to positions
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.w,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, top: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 4,
                          ),
                          margin: EdgeInsets.only(bottom: 6.w),
                          child: CustomTextWidget(
                            'Positions',
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 9.w,
                                ) ?? TextStyle(fontSize: 9.w),
                          ),
                        ),
                        Row(
                          children: [
                            CustomTextWidget(
                              'Overall P&L: ',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle?.color,
                                  ) ?? TextStyle(fontSize: 14.w),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '₹',
                                  style: TextStyle(
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w500,
                                    color: overallPLColor,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                CustomTextWidget(
                                  _positionsOverallPL,
                                  Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: overallPLColor,
                                      ) ?? TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: overallPLColor,
                                      ),
                                ),
                              ],
                            ),
                            CustomTextWidget(
                              ' ($_positionsOverallPLPercent%)',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle?.color,
                                  ) ?? TextStyle(fontSize: 14.w),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        size: 16.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildInvestBox(_positionsTodayPL, 'Today\'s P&L'),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildInvestBox(
                      _positionsTodayPLPercent,
                      'Today\'s P&L %',
                      isPercentage: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestBox(String val, String label, {bool isPercentage = false}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final valueColor = label == 'Today\'s P&L' || label == 'Today\'s P&L %'
        ? _getProfitLossColor(val)
        : null;
    
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      decoration: BoxDecoration(
        color: isLight
            ? const Color(0xFFF6F6F6)
            : Theme.of(context).colorScheme.surface.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isPercentage && label != 'Today\'s P&L %')
                Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: valueColor,
                    fontFamily: 'Arial',
                  ),
                ),
              if (!isPercentage && label != 'Today\'s P&L %') SizedBox(width: 2.w),
              CustomTextWidget(
                val + (isPercentage ? '%' : ''),
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: AppWidgetSize.fontSize14,
                      color: valueColor,
                    ) ?? TextStyle(
                      fontSize: AppWidgetSize.fontSize14,
                      color: valueColor,
                    ),
                padding: EdgeInsets.only(bottom: 4.w),
              ),
            ],
          ),
          CustomTextWidget(
            label,
            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: AppWidgetSize.fontSize10,
                ) ?? TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: AppWidgetSize.fontSize10,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingIposWidget() {
    // Dummy IPO data
    final List<Map<String, dynamic>> ipoList = [
      {
        'ipoName': 'TechCorp Solutions Ltd',
        'logoUrl': null, // Will use default IPO icon
        'priceBnd': '450 - 465',
        'minInvestPrice': '14,000',
        'offrStartDate': '2024-12-20T00:00:00',
        'offrEndDte': '2024-12-25T23:59:59',
        'isApply': 'true',
        'earlyFlg': false,
        'isSME': false,
      },
      {
        'ipoName': 'Green Energy Ventures',
        'logoUrl': null,
        'priceBnd': '120 - 125',
        'minInvestPrice': '12,000',
        'offrStartDate': '2024-12-22T00:00:00',
        'offrEndDte': '2024-12-27T23:59:59',
        'isApply': 'true',
        'earlyFlg': true,
        'isSME': true,
      },
      {
        'ipoName': 'FinTech Innovations Pvt Ltd',
        'logoUrl': null,
        'priceBnd': '280 - 290',
        'minInvestPrice': '14,000',
        'offrStartDate': '2024-12-18T00:00:00',
        'offrEndDte': '2024-12-23T23:59:59',
        'isApply': 'false',
        'earlyFlg': false,
        'isSME': false,
      },
      {
        'ipoName': 'Healthcare Services Ltd',
        'logoUrl': null,
        'priceBnd': '85 - 90',
        'minInvestPrice': '8,500',
        'offrStartDate': '2024-12-21T00:00:00',
        'offrEndDte': '2024-12-26T23:59:59',
        'isApply': 'true',
        'earlyFlg': false,
        'isSME': false,
      },
      {
        'ipoName': 'Smart Manufacturing Co',
        'logoUrl': null,
        'priceBnd': '200 - 210',
        'minInvestPrice': '20,000',
        'offrStartDate': '2024-12-19T00:00:00',
        'offrEndDte': '2024-12-24T23:59:59',
        'isApply': 'true',
        'earlyFlg': true,
        'isSME': true,
      },
    ];

    String formatDate(String? date, {bool isTimeNeeded = true}) {
      if (date == null || date.isEmpty) return '--';
      try {
        final parsedDate = DateTime.tryParse(date);
        if (parsedDate == null) return '--';
        
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        final day = parsedDate.day.toString().padLeft(2, '0');
        final month = months[parsedDate.month - 1];
        
        if (isTimeNeeded) {
          final hour = parsedDate.hour % 12 == 0 ? 12 : parsedDate.hour % 12;
          final minute = parsedDate.minute.toString().padLeft(2, '0');
          final amPm = parsedDate.hour < 12 ? 'AM' : 'PM';
          return '$day $month, $hour:$minute $amPm';
        } else {
          return '$day $month';
        }
      } catch (e) {
        return '--';
      }
    }

    if (ipoList.isEmpty) {
      return Container();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Ongoing IPOs',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 16.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                ipoList.length > 5 ? 5 : ipoList.length,
                (index) {
                  final ipo = ipoList[index];
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.all(16.w),
                    width: 330.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(
                        width: 1.w,
                        color: Theme.of(context).dividerColor,
                      ),
                      boxShadow: [], // No shadow
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            // Handle IPO tap
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo or default IPO icon
                              ipo['logoUrl'] != null && ipo['logoUrl'].toString().isNotEmpty
                                  ? Image.network(
                                      ipo['logoUrl'] as String,
                                      height: 40.w,
                                      width: 40.w,
                                      alignment: Alignment.centerLeft,
                                      errorBuilder: (context, error, stackTrace) =>
                                          AppImages.ipo(
                                            context,
                                            height: 40.w,
                                          ),
                                    )
                                  : AppImages.ipo(
                                      context,
                                      height: 40.w,
                                    ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: 200.w,
                                          ),
                                          child: CustomTextWidget(
                                            ipo['ipoName'] as String,
                                            Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  fontSize: AppWidgetSize.fontSize15,
                                                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize15),
                                            maxLines: 1,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (ipo['isSME'] == true)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 5.w,
                                              bottom: 3.w,
                                            ),
                                            child: AppImages.smeTag(
                                              context,
                                              width: 31.w,
                                              height: 17.w,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Rupee symbol with Arial font (web-safe and supports rupee)
                                        Text(
                                          '₹',
                                          style: TextStyle(
                                            fontSize: AppWidgetSize.fontSize14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.color,
                                            fontFamily: 'Arial', // Arial supports rupee symbol on web
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        CustomTextWidget(
                                          ipo['priceBnd'] as String,
                                          Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ) ?? TextStyle(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextWidget(
                                          'Min. Investment: ',
                                          Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        // Rupee symbol with Arial font
                                        Text(
                                          '₹',
                                          style: TextStyle(
                                            fontSize: AppWidgetSize.fontSize14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.color,
                                            fontFamily: 'Arial', // Arial supports rupee symbol on web
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        CustomTextWidget(
                                          ipo['minInvestPrice'] as String,
                                          Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 4.w,
                            bottom: 4.w,
                          ),
                          child: Divider(
                            color: Theme.of(context).dividerColor,
                            thickness: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(
                              ' ${formatDate(ipo['offrStartDate'] as String?, isTimeNeeded: false)} - ${formatDate(ipo['offrEndDte'] as String?, isTimeNeeded: false)}',
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: AppWidgetSize.fontSize14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            ipo['isApply'] == 'true'
                                ? GestureDetector(
                                    onTap: () {
                                      // Handle Apply tap
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: AppWidgetSize.dimen_6,
                                        left: AppWidgetSize.dimen_12,
                                        right: AppWidgetSize.dimen_12,
                                        bottom: AppWidgetSize.dimen_6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40.w),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: CustomTextWidget(
                                        ipo['earlyFlg'] == true ? 'Pre-Apply' : 'Apply',
                                        Theme.of(context)
                                            .primaryTextTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context).primaryColorLight,
                                            ) ?? TextStyle(
                                              color: Theme.of(context).primaryColorLight,
                                            ),
                                      ),
                                    ),
                                  )
                                : ipo['isApply'] == 'false'
                                    ? Container(
                                        padding: EdgeInsets.only(
                                          top: AppWidgetSize.dimen_6,
                                          left: AppWidgetSize.dimen_12,
                                          right: AppWidgetSize.dimen_12,
                                          bottom: AppWidgetSize.dimen_6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.w),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                        ),
                                        child: CustomTextWidget(
                                          'Applied',
                                          Theme.of(context)
                                              .primaryTextTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context).primaryColor,
                                              ) ?? TextStyle(
                                                color: Theme.of(context).primaryColor,
                                              ),
                                        ),
                                      )
                                    : Container(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, bottom: 16.w),
          child: GestureDetector(
            onTap: () {
              // Handle View More tap
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: AppWidgetSize.dimen_16,
                top: AppWidgetSize.dimen_6,
                right: AppWidgetSize.dimen_16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextWidget(
                    'View More',
                    Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                          fontSize: AppWidgetSize.fontSize16,
                        ) ?? TextStyle(fontSize: AppWidgetSize.fontSize16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketNewsWidget() {
    // Dummy market news data
    final List<Map<String, dynamic>> newsList = [
      {
        'date': '15 Dec 2024',
        'headline': 'Stock markets hit new highs as investors cheer economic recovery',
      },
      {
        'date': '14 Dec 2024',
        'headline': 'Tech stocks surge on strong quarterly earnings reports',
      },
      {
        'date': '13 Dec 2024',
        'headline': 'Banking sector gains momentum with positive outlook',
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                newsList.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.w),
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
                            // Handle news tap
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
                                        newsList[index]['date'] as String,
                                        Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontSize: 12.w,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .labelStyle
                                                  ?.color,
                                            ) ?? TextStyle(
                                              fontSize: 12.w,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .labelStyle
                                                  ?.color,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6.w),
                                        child: CustomTextWidget(
                                          newsList[index]['headline'] as String,
                                          Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ) ?? TextStyle(
                                                fontSize: AppWidgetSize.fontSize14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                          maxLines: 3,
                                          textOverflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color,
                                  size: 16.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, bottom: 16.w),
          child: GestureDetector(
            onTap: () {
              // Handle View More tap
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: AppWidgetSize.dimen_16,
                top: AppWidgetSize.dimen_6,
                right: AppWidgetSize.dimen_16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextWidget(
                    'View More',
                    Theme.of(context)
                        .primaryTextTheme
                        .headlineMedium
                        ?.copyWith(fontSize: AppWidgetSize.fontSize16) ??
                        TextStyle(fontSize: AppWidgetSize.fontSize16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyVisitedWidget() {
    // Dummy recently visited stocks data
    final List<Map<String, dynamic>> stocksList = [
      {
        'symbol': 'RELIANCE',
        'exchange': 'NSE',
        'ltp': '2450.50',
        'change': '+25.30',
        'changePercent': '+1.04%',
      },
      {
        'symbol': 'TCS',
        'exchange': 'NSE',
        'ltp': '3850.00',
        'change': '-15.50',
        'changePercent': '-0.40%',
      },
      {
        'symbol': 'INFY',
        'exchange': 'NSE',
        'ltp': '1650.75',
        'change': '+10.25',
        'changePercent': '+0.62%',
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Recently Visited',
            Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: AppWidgetSize.fontSize22) ??
                TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Container(
          height: 80.w,
          margin: EdgeInsets.all(16.w),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stocksList.length,
            itemBuilder: (BuildContext context, int index) {
              final stock = stocksList[index];
              final isPositive = (stock['change'] as String).startsWith('+');
              final changeColor = isPositive
                  ? AppColors.positiveColor(Theme.of(context).brightness == Brightness.light)
                  : AppColors.negativeColor;

              return GestureDetector(
                onTap: () {
                  // Handle stock tap
                },
                child: Container(
                  width: 250.w,
                  padding: EdgeInsets.all(14.w),
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      width: 1.w,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomTextWidget(
                            stock['symbol'] as String,
                            Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: AppWidgetSize.fontSize16,
                                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: LabelBorderWidget(
                              text: stock['exchange'] as String,
                              textColor: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF797979)
                                  : const Color(0xFFFFFFFF),
                              backgroundColor: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFFF2F2F2)
                                  : const Color(0xFF282F35),
                              borderColor: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFFF2F2F2)
                                  : const Color(0xFF282F35),
                              fontSize: AppWidgetSize.fontSize10,
                              margin: EdgeInsets.all(AppWidgetSize.dimen_1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '₹',
                                style: TextStyle(
                                  fontSize: AppWidgetSize.fontSize16,
                                  fontWeight: FontWeight.w500,
                                  color: changeColor,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              SizedBox(width: 2.w),
                              CustomTextWidget(
                                stock['ltp'] as String,
                                Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontSize: AppWidgetSize.fontSize16,
                                      fontWeight: FontWeight.w500,
                                      color: changeColor,
                                    ) ?? TextStyle(
                                      fontSize: AppWidgetSize.fontSize16,
                                      fontWeight: FontWeight.w500,
                                      color: changeColor,
                                    ),
                                padding: EdgeInsets.only(right: 5.w),
                              ),
                            ],
                          ),
                          CustomTextWidget(
                            stock['changePercent'] as String,
                            Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle
                                      ?.color,
                                  fontSize: AppWidgetSize.fontSize12,
                                  fontWeight: FontWeight.w400,
                                ) ?? TextStyle(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle
                                      ?.color,
                                  fontSize: AppWidgetSize.fontSize12,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildManageDashboardWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.w, top: 5.w),
        child: Row(
          children: [
            // Enjoying the app? Feedback Banner Card
            Container(
              width: 320.w,
              margin: EdgeInsets.only(left: 16.w, right: 8.w),
              padding: EdgeInsets.all(16.w),
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
                    const Color(0xFFBA68C8).withOpacity(0.08),
                  ],
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Handle feedback tap
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            'Enjoying the app?',
                            Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: AppWidgetSize.fontSize16) ??
                                TextStyle(fontSize: AppWidgetSize.fontSize16),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.w),
                            child: CustomTextWidget(
                              'Rate your experience with us',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.color,
                                  ) ?? TextStyle(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.color,
                                  ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 3,
                                ),
                                child: Image(
                                  image: AppImages.feedbackStar(),
                                  height: 18.w,
                                  width: 18.w,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Image(
                      image: AppImages.feedbackBannerImg(),
                      height: 74.w,
                      width: 74.w,
                    ),
                  ],
                ),
              ),
            ),
            // Manage Dashboard Card
            Container(
              width: 320.w,
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              padding: EdgeInsets.all(16.w),
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
                    const Color(0xFF34B350).withOpacity(0.08),
                  ],
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Handle Manage Dashboard tap
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            'Manage Dashboard',
                            Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: AppWidgetSize.fontSize16) ??
                                TextStyle(fontSize: AppWidgetSize.fontSize16),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.w),
                            child: CustomTextWidget(
                              'Rearrange and manage visibility of different sections on this page',
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.color,
                                  ) ?? TextStyle(
                                    fontSize: 14.w,
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.color,
                                  ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          CustomTextWidget(
                            'Customize Now',
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: AppWidgetSize.fontSize14,
                                  color: Theme.of(context).primaryColor,
                                ) ?? TextStyle(
                                  fontSize: AppWidgetSize.fontSize14,
                                  color: Theme.of(context).primaryColor,
                                ),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Image(
                      image: AppImages.manageDash(),
                      height: 74.w,
                      width: 74.w,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedTradingToolsWidget() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    // Dummy data for advanced trading tools
    final List<Map<String, dynamic>> productList = [
      {
        'title': 'Stratzy',
        'icon': null, // Will use placeholder icon
        'tag': 'New',
        'flag': true,
      },
      {
        'title': 'Hedged',
        'icon': null, // Will use placeholder icon
        'tag': 'None',
        'flag': true,
      },
      {
        'title': 'Quatman',
        'icon': null, // Will use placeholder icon
        'tag': 'Coming Soon',
        'flag': true,
      },
    ];

    Widget _buildTagWidget(String tagTitle) {
      if (tagTitle.toLowerCase() == 'new') {
        return Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Container(
            height: 20.w,
            width: 46.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEFDAFF),
              borderRadius: BorderRadius.circular(15.w),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 2.w,
              horizontal: 10.w,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomTextWidget(
                tagTitle,
                Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 8.w,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9A5CC8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      } else if (tagTitle.toLowerCase() == 'none') {
        return const SizedBox.shrink();
      } else {
        return Container(
          margin: EdgeInsets.only(left: 15.w),
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFAC64E2),
                Color(0xFFBE8CE4),
                Color(0xFF9A5CC8),
                Color(0xFFAC64E2),
                Color(0xFFC087EA),
              ],
            ),
          ),
          child: CustomTextWidget(
            tagTitle,
            Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 8.w,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        );
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.w),
      height: 160.w,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Candle chart image on the right
          Positioned(
            right: 0,
            bottom: -3.w,
            child: SizedBox(
              height: 150.w,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image(
                image: AppImages.candleChartImg(),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Gradient background
          Container(
            height: 150.w,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0.3, 0.5, 0.8],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: isLight
                    ? <Color>[
                        const Color(0xFF0F6421),
                        const Color(0xFF0F6421).withOpacity(0.80),
                        const Color(0xFF34B350).withOpacity(0.64),
                      ]
                    : <Color>[
                        const Color(0xFF0D551D),
                        const Color(0xFF0D551D).withOpacity(0.90),
                        const Color(0xA328833C),
                      ],
              ),
            ),
          ),
          // Content
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppWidgetSize.dimen_16),
                child: CustomTextWidget(
                  'Advanced Trading Tools',
                  Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: AppWidgetSize.fontSize22,
                        color: const Color(0xFFFFFFFF),
                      ) ?? TextStyle(
                        fontSize: AppWidgetSize.fontSize22,
                        color: const Color(0xFFFFFFFF),
                      ),
                ),
              ),
              SizedBox(height: 15.w),
              Flexible(
                child: SizedBox(
                  height: 47.w,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      if (product['flag'] == true) {
                        return GestureDetector(
                          onTap: () {
                            // Handle product tap
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: index == 0 ? AppWidgetSize.dimen_16 : 12.w),
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.w),
                              border: Border.all(
                                width: 1.w,
                                color: Theme.of(context).dividerColor,
                              ),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Product icon placeholder
                                Container(
                                  height: 20.w,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: Icon(
                                    Icons.bar_chart,
                                    size: 14.w,
                                    color: Theme.of(context).textTheme.displayLarge?.color,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                CustomTextWidget(
                                  product['title'] as String,
                                  Theme.of(context).textTheme.displayLarge!.copyWith(
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                _buildTagWidget(product['tag'] as String),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverWidget() {
    Widget _buildNewTagWidget() {
      return Padding(
        padding: EdgeInsets.only(left: 12.w, bottom: 3.w),
        child: Container(
          height: 20.w,
          width: 46.w,
          decoration: BoxDecoration(
            color: const Color(0xFFEFDAFF),
            borderRadius: BorderRadius.circular(15.w),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 2.w,
            horizontal: 10.w,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomTextWidget(
              'New',
              Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF9A5CC8),
                    fontSize: AppWidgetSize.fontSize15,
                    fontWeight: FontWeight.w500,
                  ) ?? TextStyle(
                    color: const Color(0xFF9A5CC8),
                    fontSize: AppWidgetSize.fontSize15,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    Widget _buildExploreContentWidget(
      ImageProvider<Object> image,
      String label, {
      bool isShowNewTag = false,
    }) {
      return Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: CustomTextWidget(
                label,
                Theme.of(context).primaryTextTheme.labelSmall ?? TextStyle(
                  fontSize: AppWidgetSize.fontSize14,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
              ),
            ),
            if (isShowNewTag) _buildNewTagWidget(),
          ],
        ),
        backgroundColor: const Color(0xFF34B350).withOpacity(0.07),
        shape: StadiumBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF34B350).withOpacity(0.13),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 10.w),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Discover',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // First row
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 3,
                  ),
                  child: Wrap(
                    runSpacing: 8.w,
                    spacing: 8.w,
                    alignment: WrapAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle STOCK SIP tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverSip(),
                          'STOCK SIP',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle SCANNERS tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverScanners(),
                          'SCANNERS',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle NCD tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverNcd(),
                          'NCD',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle FII DII ACTIVITY tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverfiidii(),
                          'FII DII ACTIVITY',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle SUPPORT tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverSupport(),
                          'SUPPORT',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.w),
                // Second row
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 3,
                  ),
                  child: Wrap(
                    runSpacing: 8.w,
                    spacing: 8.w,
                    alignment: WrapAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle BUY BACK tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverGtd(),
                          'BUY BACK',
                          isShowNewTag: false, // Set to true if needed
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle GTD tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverGtd(),
                          'GTD',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle RESEARCH tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverResearch(),
                          'RESEARCH',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle BASKET ORDERS tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverBasket(),
                          'BASKET ORDERS',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle SMART REPORTS tap
                        },
                        child: _buildExploreContentWidget(
                          AppImages.discoverReports(),
                          'SMART REPORTS',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReferAndEarnWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, left: 16.w, bottom: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Refer & Earn Card
            Container(
              width: 300.w,
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  width: 1.w,
                  color: Theme.of(context).dividerColor,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4A7717),
                    Color(0xFF4F6345),
                    Color(0xFF4E4A3E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          'Refer & Earn ₹30,000',
                          Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: AppWidgetSize.fontSize16,
                                color: const Color(0xFFD6E56E),
                                fontWeight: FontWeight.w600,
                              ) ?? TextStyle(
                                fontSize: AppWidgetSize.fontSize16,
                                color: const Color(0xFFD6E56E),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          child: CustomTextWidget(
                            'Refer your friends and start earning today — T&Cs apply.',
                            Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: AppWidgetSize.fontSize13,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ) ?? TextStyle(
                                  fontSize: AppWidgetSize.fontSize13,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                        ),
                        gradientButtonWidget(
                          onTap: () {
                            // Handle Refer Now tap
                          },
                          width: AppWidgetSize.dimen_100,
                          height: AppWidgetSize.dimen_30,
                          key: const Key("bannerCallToActionKey"),
                          fontsize: AppWidgetSize.dimen_13,
                          fontWeight: FontWeight.w500,
                          context: context,
                          title: "Refer Now",
                          isGradient: true,
                          bottom: 0,
                        ),
                      ],
                    ),
                  ),
                  Image(
                    image: AppImages.referAndEarnBannerImg(),
                    height: 85.w,
                    width: 85.w,
                  ),
                ],
              ),
            ),
            // Stock SIP Card
            Container(
              width: 300.w,
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                  width: 1.w,
                  color: Theme.of(context).dividerColor,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF577EC6),
                    Color(0xFF9846D2),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          'Stock SIP',
                          Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: AppWidgetSize.fontSize16,
                                color: const Color(0xFFD6E56E),
                                fontWeight: FontWeight.w600,
                              ) ?? TextStyle(
                                fontSize: AppWidgetSize.fontSize16,
                                color: const Color(0xFFD6E56E),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          child: CustomTextWidget(
                            'Unleash the power of compounding with Stock SIPs!',
                            Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: AppWidgetSize.fontSize13,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ) ?? TextStyle(
                                  fontSize: AppWidgetSize.fontSize13,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        gradientButtonWidget(
                          onTap: () {
                            // Handle Invest through SIP tap
                          },
                          width: AppWidgetSize.dimen_120,
                          height: AppWidgetSize.dimen_30,
                          key: const Key("bannerInvestThroughSIPKey"),
                          fontsize: AppWidgetSize.dimen_13,
                          fontWeight: FontWeight.w500,
                          context: context,
                          title: "Invest through SIP",
                          isGradient: true,
                          bottom: 0,
                        ),
                      ],
                    ),
                  ),
                  Image(
                    image: AppImages.cmsSip(),
                    height: 74.w,
                    width: 74.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyFundsWidget() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final fundsColor = _getProfitLossColor(_availableForInvesting);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'My Funds',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              width: 1.w,
              color: Theme.of(context).dividerColor,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).dividerColor,
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: isLight
                        ? const Color(0xFFEBFFEC).withOpacity(0.8)
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Image(
                    image: AppImages.fundsCoin(),
                    height: 40.w,
                    width: 40.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₹',
                            style: TextStyle(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: fundsColor,
                              fontFamily: 'Arial',
                            ),
                          ),
                          SizedBox(width: 2.w),
                          CustomTextWidget(
                            _availableForInvesting,
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 16.w,
                                  color: fundsColor,
                                  fontWeight: FontWeight.w500,
                                ) ?? TextStyle(
                                  fontSize: 16.w,
                                  color: fundsColor,
                                  fontWeight: FontWeight.w500,
                                ),
                            padding: EdgeInsets.only(bottom: 4.w),
                          ),
                        ],
                      ),
                      CustomTextWidget(
                        'Available for investing',
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 14.w,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle?.color,
                            ) ?? TextStyle(fontSize: 14.w),
                      ),
                    ],
                  ),
                ),
                // Add Funds button
                gradientButtonWidget(
                  fontsize: 14.w,
                  fontWeight: FontWeight.w500,
                  onTap: () {
                    // Handle Add Funds tap
                  },
                  width: AppWidgetSize.dimen_90,
                  height: 36.w,
                  key: const Key('emptyWidgetButton1Key'),
                  context: context,
                  bottom: 0,
                  title: 'Add Funds',
                  isGradient: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Products',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _menuItem(
                  label: "Stocks",
                  icon: AppImages.productCash(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle Stocks tap
                  },
                ),
                _menuItem(
                  label: "F&O",
                  icon: AppImages.productFO(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle F&O tap
                  },
                ),
                _menuItem(
                  label: "MF Overview",
                  icon: AppImages.productMFOverview(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle MF Overview tap
                  },
                ),
                _menuItem(
                  label: "IPO",
                  icon: AppImages.productIpo(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle IPO tap
                  },
                ),
                _menuItem(
                  label: "ETF",
                  icon: AppImages.productETF(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle ETF tap
                  },
                ),
                _menuItem(
                  label: "NCD",
                  icon: AppImages.productNCD(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle NCD tap
                  },
                ),
                _menuItem(
                  label: "Currency",
                  icon: AppImages.productCurrency(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle Currency tap
                  },
                ),
                _menuItem(
                  label: "Commodity",
                  icon: AppImages.productCommodity(
                    context,
                    height: AppWidgetSize.dimen_24,
                    width: AppWidgetSize.dimen_24,
                  ),
                  onTap: () {
                    // Handle Commodity tap
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _menuItem({
    required Widget icon,
    required String label,
    required Function onTap,
  }) {
    return GestureDetector(
      child: SizedBox(
        height: AppWidgetSize.dimen_100,
        width: AppWidgetSize.dimen_80,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: AppWidgetSize.dimen_48,
                width: AppWidgetSize.dimen_48,
                decoration: BoxDecoration(
                  color: const Color(0xFFAC64E2).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppWidgetSize.dimen_8),
                ),
                alignment: Alignment.center,
                child: icon,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomTextWidget(
                  label,
                  Theme.of(context).textTheme.titleLarge!,
                  padding: EdgeInsets.only(top: AppWidgetSize.dimen_4),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }

  Widget _buildThemesWidget() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    // Dummy themes data with gradient backgrounds (simulating images)
    final List<Map<String, dynamic>> themes = [
      {
        'title': 'Electric Vehicles',
        'description': 'EV',
        'followCount': 12500,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF4A90E2)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
      {
        'title': 'Renewable Energy',
        'description': 'RE',
        'followCount': 8900,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF66BB6A)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
      {
        'title': 'FinTech',
        'description': 'FT',
        'followCount': 15200,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC62828), Color(0xFFE53935), Color(0xFFFF6B6B)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
      {
        'title': 'Healthcare',
        'description': 'HC',
        'followCount': 11200,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
      {
        'title': 'E-Commerce',
        'description': 'EC',
        'followCount': 9800,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE65100), Color(0xFFFF6F00), Color(0xFFFFA726)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
      {
        'title': 'AI & ML',
        'description': 'AI',
        'followCount': 18700,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF006064), Color(0xFF00838F), Color(0xFF00BCD4)],
        ),
        'titleColor': 0xFFFFFFFF,
      },
    ];

    String formatFollowersCount(int count) {
      if (count >= 1000) {
        return '${(count / 1000).toStringAsFixed(1)}k';
      }
      return count.toString();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextWidget(
                'Themes',
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: AppWidgetSize.fontSize22,
                    ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  // Handle info icon tap
                },
                child: AppImages.informationIcon(
                  context,
                  color: Theme.of(context).primaryIconTheme.color,
                  isColor: true,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.w),
          CustomTextWidget(
            'Explore companies by themes curated just for you.',
            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                ) ?? TextStyle(
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                ),
          ),
          SizedBox(height: 12.w),
          AspectRatio(
            aspectRatio: 3.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: themes.length > 6 ? 6 : themes.length,
              itemBuilder: (context, index) {
                final theme = themes[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle theme tap
                        },
                        child: Container(
                          height: 82.w,
                          width: AppWidgetSize.screenWidth(context) * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.w),
                            border: Border.all(
                              color: const Color(0xFFDDDDDD),
                              width: 1.w,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.w),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Background gradient (simulating image)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.w),
                                    gradient: theme['gradient'] as LinearGradient,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.w),
                                      // Add some overlay for depth
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Theme description text
                                Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomTextWidget(
                                      theme['description'] as String,
                                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                                            fontSize: AppWidgetSize.headline5Size,
                                            fontWeight: FontWeight.w600,
                                            color: Color(theme['titleColor'] as int),
                                          ) ?? TextStyle(
                                            fontSize: AppWidgetSize.headline5Size,
                                            fontWeight: FontWeight.w600,
                                            color: Color(theme['titleColor'] as int),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Heart icon in blue color (first)
                          AppImages.heartIcon(
                            context,
                            width: 12.w,
                            height: 12.w,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 3.w),
                          // Followers text (after heart icon)
                          Flexible(
                            child: CustomTextWidget(
                              '${formatFollowersCount(theme['followCount'] as int)} followers',
                              Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                                    fontSize: 10.w,
                                    color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                                  ) ?? TextStyle(
                                    fontSize: 10.w,
                                    color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                                  ),
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (themes.length > 6)
            GestureDetector(
              onTap: () {
                // Handle View More tap
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.w, bottom: 15.w),
                alignment: Alignment.topRight,
                child: CustomTextWidget(
                  'View More',
                  Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                        fontSize: AppWidgetSize.fontSize16,
                      ) ?? TextStyle(fontSize: AppWidgetSize.fontSize16),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExploreEtfsWidget() {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Explore ETFs',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.w, bottom: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle GOLD ETF tap
                  },
                  child: _buildGradientExploreContentWidget(
                    borderGradient: const LinearGradient(
                      colors: [
                        Color(0xFFF5F0AA),
                        Color(0xFFFFFFEE),
                        Color(0xFFF3E694),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF9C2),
                        Color(0xFFFFFFF5),
                        Color(0xFFFFF5D3),
                        Color(0xFFEDEBAE),
                        Color(0xFFFFF9EC),
                        Color(0xFFFFF1C2),
                      ],
                      stops: [0.2, 0.3, 0.4, 0.6, 0.9, 1],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    image: AppImages.goldEtf(),
                    label: 'GOLD',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle SILVER ETF tap
                  },
                  child: _buildGradientExploreContentWidget(
                    borderGradient: const LinearGradient(
                      colors: [
                        Color(0xFFCCCCCC),
                        Color(0xFFFFFFEE),
                        Color(0xFFDDDDDD),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEEEEEE),
                        Color(0xFFF6F6F6),
                        Color(0xFFFFFFFF),
                        Color(0xFFDADADA),
                        Color(0xFFFFFFFF),
                        Color(0xFFDDDDDD),
                      ],
                      stops: [0.1, 0.2, 0.3, 0.5, 0.8, 1],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    image: AppImages.silverEtf(),
                    label: 'SILVER',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle INDEX ETF tap
                  },
                  child: _buildExploreContentWidget(
                    AppImages.indexEtf(),
                    'INDEX',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle DEBT ETF tap
                  },
                  child: _buildExploreContentWidget(
                    AppImages.debtEtf(),
                    'DEBT',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle GLOBAL ETF tap
                  },
                  child: _buildExploreContentWidget(
                    AppImages.globalEtf(),
                    'GLOBAL',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle Others ETF tap
                  },
                  child: _buildExploreContentWidget(
                    AppImages.othersEtf(),
                    'Others',
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildViewMoreWidget('View More'),
      ],
    );
  }

  Widget _buildGradientExploreContentWidget({
    required Gradient borderGradient,
    required Gradient gradient,
    required AssetImage image,
    required String label,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        gradient: borderGradient,
        borderRadius: BorderRadius.circular(30.w),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 13.w),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: image,
              height: 21.w,
              width: 21.w,
            ),
            SizedBox(width: AppWidgetSize.dimen_7),
            CustomTextWidget(
              label,
              isLight
                  ? Theme.of(context).primaryTextTheme.labelSmall
                  : Theme.of(context).primaryTextTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreContentWidget(AssetImage image, String label) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: image,
            height: 21.w,
            width: 21.w,
          ),
          SizedBox(width: AppWidgetSize.dimen_7),
          CustomTextWidget(
            label,
            Theme.of(context).primaryTextTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildResearchWidget() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final successPercent = 75;
    final failPercent = 25;
    final daysText = 'Last 30 days';

    // Dummy research cards
    final researchCards = [
      {
        'symbol': 'RELIANCE',
        'callType': 'Buy',
        'entryPrice': '2450.50',
        'targetPrice': '2600.00',
        'stopLoss': '2350.00',
        'ltp': '2455.00',
        'isOpen': true,
      },
      {
        'symbol': 'TCS',
        'callType': 'Buy',
        'entryPrice': '3850.00',
        'targetPrice': '4000.00',
        'stopLoss': '3750.00',
        'ltp': '3900.00',
        'isOpen': true,
      },
      {
        'symbol': 'INFY',
        'callType': 'Sell',
        'entryPrice': '1520.00',
        'targetPrice': '1450.00',
        'stopLoss': '1580.00',
        'ltp': '1500.00',
        'isOpen': true,
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          child: CustomTextWidget(
            'Stock Ideas',
            Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: AppWidgetSize.fontSize22,
                ) ?? TextStyle(fontSize: AppWidgetSize.fontSize22),
          ),
        ),
        // Call Performance Card
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            decoration: BoxDecoration(
              color: isLight
                  ? const Color(0xFFFFF9E6)
                  : const Color(0xFF2A2418),
              borderRadius: BorderRadius.circular(AppWidgetSize.dimen_8),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextWidget(
                          'Call Performance',
                          Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                              ) ?? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                              ),
                        ),
                        SizedBox(height: AppWidgetSize.dimen_4),
                        Text(
                          daysText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12.w,
                              ) ?? TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12.w,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppWidgetSize.dimen_16,
                          right: AppWidgetSize.dimen_4,
                        ),
                        child: CustomTextWidget(
                          '$successPercent%',
                          Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                                color: AppColors.positiveColor(isLight),
                              ) ?? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                                color: AppColors.positiveColor(isLight),
                              ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.positiveColor(isLight).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        height: 40.w,
                        width: 40.w,
                        padding: EdgeInsets.all(10.w),
                        child: Icon(
                          Icons.thumb_up,
                          color: AppColors.positiveColor(isLight),
                          size: 20.w,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppWidgetSize.dimen_16,
                          right: AppWidgetSize.dimen_4,
                        ),
                        child: CustomTextWidget(
                          '$failPercent%',
                          Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                                color: AppColors.negativeColor,
                              ) ?? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.w,
                                color: AppColors.negativeColor,
                              ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.negativeColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        height: 40.w,
                        width: 40.w,
                        padding: EdgeInsets.all(10.w),
                        child: Icon(
                          Icons.thumb_down,
                          color: AppColors.negativeColor,
                          size: 20.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Research Cards
        SizedBox(
          height: 260.w,
          child: ListView.builder(
            primary: false,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: researchCards.length,
            padding: EdgeInsets.only(
              right: AppWidgetSize.dimen_16,
              left: AppWidgetSize.dimen_8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildResearchCard(researchCards[index], isLight);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResearchCard(Map<String, dynamic> cardData, bool isLight) {
    final isOpen = cardData['isOpen'] as bool;
    final callType = cardData['callType'] as String;
    final isBuy = callType.toLowerCase() == 'buy';
    
    Color backGroundColor = isLight
        ? const Color(0xFFF2F2F2)
        : const Color(0xFF282F35);
    Color textColor = isLight
        ? const Color(0xFF797979)
        : const Color(0xFFFFFFFF);

    return Padding(
      padding: EdgeInsets.only(bottom: 10.w, left: 8.w),
      child: Container(
        width: 335.w,
        decoration: BoxDecoration(
          color: isOpen
              ? Colors.transparent
              : (isLight
                  ? const Color(0xFFF6F6F6)
                  : Theme.of(context).colorScheme.surface.withOpacity(0.5)),
          border: Border.all(
            width: 1.w,
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResearchTop(cardData, isLight, backGroundColor, textColor),
              _buildResearchSlider(cardData, isBuy),
              _buildResearchDetails(cardData, isBuy),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResearchTop(
    Map<String, dynamic> cardData,
    bool isLight,
    Color backGroundColor,
    Color textColor,
  ) {
    final isOpen = cardData['isOpen'] as bool;
    final symbol = cardData['symbol'] as String;
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.positiveColor(isLight).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              height: 26.w,
              width: 26.w,
              child: Center(
                child: Text(
                  symbol.substring(0, 1).toUpperCase(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: AppWidgetSize.fontSize16,
                        color: AppColors.positiveColor(isLight),
                        fontWeight: FontWeight.w600,
                      ) ?? TextStyle(
                        fontSize: AppWidgetSize.fontSize16,
                        color: AppColors.positiveColor(isLight),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 180.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            symbol,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .labelSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: LabelBorderWidget(
                          text: isOpen ? 'OPEN' : 'CLOSED',
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 3.w,
                          ),
                          textColor: isOpen
                              ? AppColors.positiveColor(isLight)
                              : const Color(0xFF797979),
                          backgroundColor: isOpen
                              ? Theme.of(context).snackBarTheme.backgroundColor
                              : const Color(0xFFDDDDDD),
                          borderColor: Colors.transparent,
                          fontSize: AppWidgetSize.fontSize10,
                          margin: EdgeInsets.all(AppWidgetSize.dimen_1),
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
                    child: Text(
                      'Published: 15 Jan 2024',
                      style: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                            fontSize: 12.w,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle?.color,
                          ) ?? TextStyle(fontSize: 12.w),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.w),
        Row(
          children: [
            LabelBorderWidget(
              text: 'Intraday',
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
              textColor: textColor,
              borderRadius: 16.w,
              backgroundColor: Colors.transparent,
              borderColor: const Color(0xFFDDDDDD),
              fontSize: AppWidgetSize.fontSize10,
              margin: EdgeInsets.all(AppWidgetSize.dimen_1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResearchSlider(Map<String, dynamic> cardData, bool isBuy) {
    final entry = double.tryParse(cardData['entryPrice'] as String) ?? 0.0;
    final stopLoss = double.tryParse(
      isBuy ? (cardData['stopLoss'] as String) : (cardData['targetPrice'] as String),
    ) ?? 0.0;
    final target = double.tryParse(
      isBuy ? (cardData['targetPrice'] as String) : (cardData['stopLoss'] as String),
    ) ?? 0.0;
    final ltp = double.tryParse(cardData['ltp'] as String) ?? 0.0;
    
    double availWidth = 335.w - 74.w;
    double slWidth = availWidth * ((entry - stopLoss) / (target - stopLoss));
    double targetWidth = availWidth * ((target - entry) / (target - stopLoss));
    double widthOfPointer = 12.w;

    if (ltp >= entry) {
      widthOfPointer = 30.w + slWidth;
      widthOfPointer = widthOfPointer + (targetWidth * ((ltp - entry) / (target - entry)));
      if (widthOfPointer > (availWidth + 28.w)) {
        widthOfPointer = availWidth + 28.w;
      }
    } else {
      widthOfPointer = 12.w;
      widthOfPointer = widthOfPointer + (slWidth * ((ltp - stopLoss) / (entry - stopLoss)));
      if (widthOfPointer < 12.w) {
        widthOfPointer = 12.w;
      }
    }

    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: EdgeInsets.only(top: 8.w),
      child: Stack(
        children: [
          SizedBox(
            height: 32.w,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: isBuy ? AppColors.negativeColor : AppColors.positiveColor(isLight),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 4,
                    width: slWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isBuy
                            ? [
                                const Color(0xFFCB5339),
                                const Color(0xFFCB5339).withOpacity(0.05),
                              ]
                            : [
                                const Color(0xFF34B350),
                                const Color(0xFF34B350).withOpacity(0.05),
                              ],
                      ),
                    ),
                  ),
                  Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isBuy
                              ? [
                                  const Color(0xFF34B350),
                                  const Color(0xFF34B350).withOpacity(0.05),
                                ]
                              : [
                                  const Color(0xFFCB5339),
                                  const Color(0xFFCB5339).withOpacity(0.05),
                                ],
                          begin: const FractionalOffset(1.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                        ),
                      ),
                      width: targetWidth,
                      height: 4,
                    ),
                  ),
                  Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: isBuy ? AppColors.positiveColor(isLight) : AppColors.negativeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (ltp >= stopLoss && ltp <= target)
            Positioned(
              left: widthOfPointer,
              top: 14.w,
              child: Icon(
                Icons.arrow_drop_down,
                size: 8.w,
                color: Theme.of(context).primaryColor,
              ),
            ),
          Positioned(
            left: widthOfPointer - 20.w,
            top: 20.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  'LTP:',
                  Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 10.w,
                      ) ?? TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 10.w,
                      ),
                ),
                Text(
                  cardData['ltp'] as String,
                  style: Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.w,
                      ) ?? TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.w,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchDetails(Map<String, dynamic> cardData, bool isBuy) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.w, top: 10.w),
          child: Row(
            children: [
              _buildDetailRow(
                isBuy ? 'Stop Loss' : 'Target Price',
                '₹${isBuy ? cardData['stopLoss'] : cardData['targetPrice']}',
                CrossAxisAlignment.start,
              ),
              _buildDetailRow(
                'Entry Price',
                '₹${cardData['entryPrice']}',
                CrossAxisAlignment.center,
              ),
              _buildDetailRow(
                isBuy ? 'Target Price' : 'Stop Loss',
                '₹${isBuy ? cardData['targetPrice'] : cardData['stopLoss']}',
                CrossAxisAlignment.end,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Handle view details
              },
              child: CustomTextWidget(
                'View Details',
                Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                      fontSize: 14.w,
                    ) ?? TextStyle(fontSize: 14.w),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String val, CrossAxisAlignment align) {
    return Expanded(
      child: Column(
        crossAxisAlignment: align,
        children: [
          CustomTextWidget(
            val,
            Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.w,
                ) ?? TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.w,
                ),
          ),
          SizedBox(height: 4.w),
          CustomTextWidget(
            title,
            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                  fontSize: 12.w,
                  color: Theme.of(context)
                      .inputDecorationTheme
                      .labelStyle?.color,
                ) ?? TextStyle(fontSize: 12.w),
          ),
        ],
      ),
    );
  }

  Color _getProfitLossColor(String? value) {
    if (value == null || value.isEmpty || value == '--') {
      return Theme.of(context).primaryTextTheme.labelLarge!.color!;
    }
    final doubleValue = double.tryParse(value.replaceAll(',', '')) ?? 0;
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (doubleValue > 0) {
      return AppColors.positiveColor(isLight);
    } else if (doubleValue < 0) {
      return AppColors.negativeColor;
    }
    return Theme.of(context).primaryTextTheme.labelLarge!.color!;
  }
}

