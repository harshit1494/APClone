import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_images.dart';
import '../utils/app_widget_size.dart';
import '../widgets/custom_text_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _tabs = [
    'All',
    'Index',
    'Stocks',
    'IPO',
    'ETFs',
    'Future',
    'Options',
    'Commodity',
    'Currency',
  ];
  String _selectedTab = 'All';

  final List<Map<String, String>> _recentSearches = [
    {'symbol': 'RELIANCE', 'exchange': 'NSE'},
    {'symbol': 'NIFTY 50', 'exchange': 'IDX'},
    {'symbol': 'BANKNIFTY', 'exchange': 'IDX'},
    {'symbol': 'TCS', 'exchange': 'NSE'},
  ];
  final List<String> _trendingSearches = [
    'SBIN',
    'HDFCBANK',
    'INFY',
    'IRFC',
    'ZOMATO',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(context),
          _buildTabs(context),
          _buildHeader(context, 'Recent Search'),
          _buildRecentSearchList(context),
          _buildHeader(context, 'Trending Searches on ArihantPlus'),
          _buildChipRow(context, _trendingSearches),
          _buildHeader(context, 'Explore'),
          _buildExploreChips(context),
          _buildThemesSection(context),
          _buildMostBoughtSection(context),
          SizedBox(height: 12.w),
        ],
      ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 90.w,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStoriesDiscoveryIcon(context),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              height: 45.w,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: const Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 19.w,
                    color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomTextWidget(
                      'Search eg: TCS, M&M or Infy',
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 14.w,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle
                                ?.color,
                          ) ??
                          TextStyle(fontSize: 14.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoriesDiscoveryIcon(BuildContext context) {
    return Container(
      width: 41.w,
      height: 41.w,
      alignment: Alignment.center,
      padding: EdgeInsets.all(2.5.w),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.5.w, color: const Color(0xFFAC64E2)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(7.w),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xA3AC64E2),
              Color(0x33AC64E2),
              Color(0x66AC64E2),
              Color(0x1AAC64E2),
              Color(0xA3AC64E2),
            ],
          ),
        ),
        child: AppImages.APIc(context, width: 20.w, height: 20.w),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w, bottom: 4.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final isActive = tab == _selectedTab;
            return Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: GestureDetector(
                onTap: () => setState(() => _selectedTab = tab),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16.w, 4.w, 16.w, 4.w),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).snackBarTheme.backgroundColor?.withOpacity(0.9)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.w),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: CustomTextWidget(
                    tab,
                    Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.titleLarge?.color,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                        ) ??
                        TextStyle(fontSize: 16.w),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w, bottom: 8.w),
      child: Row(
        children: [
          CustomTextWidget(title, Theme.of(context).textTheme.headlineMedium),
          SizedBox(width: 4.w),
          AppImages.informationIcon(
            context,
            color: Theme.of(context).primaryIconTheme.color,
            isColor: true,
            width: 20.w,
            height: 20.w,
          ),
        ],
      ),
    );
  }

  Widget _buildChipRow(BuildContext context, List<String> items) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8.w,
          runSpacing: 8.w,
          children: items.map((e) => _buildGradientChip(e)).toList(),
        ),
      ),
    );
  }

  Widget _buildRecentSearchList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: ListView.separated(
          itemCount: _recentSearches.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          itemBuilder: (context, index) {
            final item = _recentSearches[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomTextWidget(
                        item['symbol']!,
                        Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: CustomTextWidget(
                          item['exchange']!,
                          Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                fontSize: 9.w,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xA3434343),
                              ) ??
                              TextStyle(fontSize: 9.w),
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(height: 1.5, thickness: 1.2),
        ),
      ),
    );
  }

  Widget _buildGradientChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(172, 100, 226, 0.122),
        gradient: const LinearGradient(
          colors: [
            Color(0x5234B350),
            Color(0x3D56B334),
            Color(0x3334B350),
            Color(0x1E34B363),
            Color(0x5234B350),
          ],
        ),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xFF34B350)),
      ),
      child: CustomTextWidget(
        title,
        const TextStyle(
          color: Color(0xFF34B350),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildExploreChips(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildExploreChip(
                  context,
                  AppImages.researchLogo(context, width: 24.w, height: 24.w),
                  'ARIHANT RESEARCH',
                ),
                SizedBox(width: 8.w),
                _buildExploreChip(
                  context,
                  SvgPicture.asset('assets/images/nifty_50.svg', width: 24.w, height: 24.w),
                  'NIFTY 50',
                ),
                SizedBox(width: 8.w),
                _buildExploreChip(
                  context,
                  SvgPicture.asset('assets/images/bank_nifty.svg', width: 24.w, height: 24.w),
                  'BANK NIFTY',
                ),
                SizedBox(width: 8.w),
                _buildExploreChip(
                  context,
                  SvgPicture.asset('assets/images/nifty_midcap.svg', width: 24.w, height: 24.w),
                  'TOP GAINERS',
                ),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                _buildExploreChip(
                  context,
                  Image.asset('assets/images/top_losers.png', width: 24.w, height: 24.w),
                  'TOP LOSERS',
                ),
                SizedBox(width: 8.w),
                _buildExploreChip(
                  context,
                  SvgPicture.asset('assets/images/bull.svg', width: 24.w, height: 24.w),
                  'WH NIFTY',
                ),
                SizedBox(width: 8.w),
                _buildExploreChip(
                  context,
                  SvgPicture.asset('assets/images/bear.svg', width: 24.w, height: 24.w),
                  'WL NIFTY',
                ),
              ],
            ),
        ],
        ),
      ),
    );
  }

  Widget _buildThemesSection(BuildContext context) {
    final List<Map<String, dynamic>> themes = [
      {
        'description': 'EV',
        'followCount': 12500,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF4A90E2)],
        ),
      },
      {
        'description': 'RE',
        'followCount': 8900,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF66BB6A)],
        ),
      },
      {
        'description': 'FT',
        'followCount': 15200,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC62828), Color(0xFFE53935), Color(0xFFFF6B6B)],
        ),
      },
      {
        'description': 'HC',
        'followCount': 11200,
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        ),
      },
    ];

    String formatFollowersCount(int count) {
      if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
      return count.toString();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    ) ??
                    TextStyle(fontSize: AppWidgetSize.fontSize22),
              ),
              SizedBox(width: 8.w),
              AppImages.informationIcon(
                context,
                color: Theme.of(context).primaryIconTheme.color,
                isColor: true,
                width: 20.w,
                height: 20.w,
              ),
            ],
          ),
          SizedBox(height: 4.w),
          CustomTextWidget(
            'Explore companies by themes curated just for you.',
            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                ) ??
                TextStyle(
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                ),
          ),
          SizedBox(height: 12.w),
          AspectRatio(
            aspectRatio: 3.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: themes.length,
              itemBuilder: (context, index) {
                final theme = themes[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 82.w,
                        width: AppWidgetSize.screenWidth(context) * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.w),
                          border: Border.all(color: const Color(0xFFDDDDDD), width: 1.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: theme['gradient'] as LinearGradient,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomTextWidget(
                                  theme['description'] as String,
                                  Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontSize: AppWidgetSize.headline5Size,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppImages.heartIcon(
                            context,
                            width: 12.w,
                            height: 12.w,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 3.w),
                          CustomTextWidget(
                            '${formatFollowersCount(theme['followCount'] as int)} followers',
                            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                                  fontSize: 10.w,
                                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                                ) ??
                                TextStyle(fontSize: 10.w),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.w, bottom: 15.w),
            alignment: Alignment.topRight,
            child: CustomTextWidget(
              'View More',
              Theme.of(context).primaryTextTheme.headlineMedium?.copyWith(
                    fontSize: AppWidgetSize.fontSize16,
                  ) ??
                  TextStyle(fontSize: AppWidgetSize.fontSize16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreChip(BuildContext context, Widget icon, String label) {
    return Chip(
      avatar: icon,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
            child: CustomTextWidget(
              label,
              Theme.of(context).primaryTextTheme.labelSmall,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1.0,
      shape: StadiumBorder(
        side: BorderSide(width: 0.5, color: Theme.of(context).dividerColor),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
    );
  }

  Widget _buildMostBoughtSection(BuildContext context) {
    final List<String> items = [
      'RELIANCE',
      'HDFCBANK',
      'INFY',
      'SBIN',
      'TATASTEEL',
      'ICICIBANK',
    ];
    final bool showAll = false;
    final int visibleCount = showAll ? items.length : (items.length > 5 ? 5 : items.length);

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.w),
      child: Column(
        children: [
          _buildHeader(context, 'Most bought on ArihantPlus'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDDDDDD)),
              borderRadius: BorderRadius.circular(10.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView.separated(
              itemCount: visibleCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Placeholder
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          items[index],
                          Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ) ??
                              const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 1.5, thickness: 1.5);
              },
            ),
          ),
          if (items.length > 5)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
              child: Align(
                alignment: Alignment.topRight,
                child: CustomTextWidget(
                  'View All',
                  Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xFF34B350),
                      ) ??
                      const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF34B350),
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

