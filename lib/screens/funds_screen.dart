import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/gradient_button_widget.dart';
import '../widgets/toggle_circular_tabs_widget.dart';
import 'research_reinvented_screen.dart';

class FundsScreen extends StatefulWidget {
  const FundsScreen({Key? key}) : super(key: key);

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final List<String> _toggleList = ['Equity', 'Commodity'];

  // Dummy data
  String _availableForInvesting = '1,50,000.00';
  String _accountBalance = '2,00,000.00';
  String _withdrawalCash = '1,80,000.00';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: _selectedTabIndex,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
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
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        // Top App Bar
        Container(
          height: AppWidgetSize.dimen_66,
          decoration: BoxDecoration(
            color: Theme.of(context).snackBarTheme.backgroundColor,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 8.w,
                  bottom: 8.w,
                ),
                child: _buildEquityCommodityTabBar(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Row(
                  children: [
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
                    SizedBox(width: 8.w),
                    // Market indices icon (same style as reference funds screen)
                    Container(
                      margin: EdgeInsets.only(right: AppWidgetSize.dimen_12),
                      child: AppImages.marketsPullDown(
                        context,
                        isColor: true,
                        color: Theme.of(context).primaryIconTheme.color,
                        width: 25.w,
                        height: 25.w,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 23.w),
                      child: GestureDetector(
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
                              'JD',
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Body
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          _buildAvailableBalanceDetailsAndFundsView(),
                          Container(
                            color: Colors.transparent,
                            height: AppWidgetSize.dimen_66,
                          ),
                        ],
                      ),
                      Positioned(
                        top: AppWidgetSize.dimen_210 - AppWidgetSize.dimen_60,
                        child: _buildFundDetailWidget(),
                      ),
                    ],
                  ),
                  if (_selectedTabIndex == 0)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 8.w,
                        bottom: 8.w,
                      ),
                      child: _buildPledgeButton(),
                    ),
                  // Overview Section
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppWidgetSize.dimen_12,
                      left: AppWidgetSize.dimen_20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTextWidget(
                        'Overview',
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: AppWidgetSize.dimen_20,
                            ),
                      ),
                    ),
                  ),
                  _buildFundDetailsData(),
                  SizedBox(height: AppWidgetSize.dimen_100),
                ],
              ),
            ),
          ),
        ),
        // Footer Buttons
        Container(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_20,
            right: AppWidgetSize.dimen_20,
            bottom: AppWidgetSize.dimen_8,
          ),
          color: Colors.transparent,
          height: AppWidgetSize.dimen_64,
          child: _buildFooterButtons(),
        ),
      ],
    );
  }

  Widget _buildEquityCommodityTabBar() {
    return SizedBox(
      width: AppWidgetSize.screenWidth(context) * 0.5,
      child: ToggleCircularTabsWidget(
        key: const Key('fundsToggleWidget'),
        tabController: _tabController,
        minWidth: 120.w,
        cornerRadius: AppWidgetSize.dimen_20,
        labels: _toggleList,
        initialLabel: _selectedTabIndex,
        fontSize: 15.w,
        onToggle: (int selectedTabValue) {
          setState(() {
            _selectedTabIndex = selectedTabValue;
          });
          _tabController.animateTo(selectedTabValue);
        },
      ),
    );
  }

  Widget _buildAvailableBalanceDetailsAndFundsView() {
    return Container(
      height: AppWidgetSize.dimen_210,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: AppWidgetSize.dimen_8),
      color: Theme.of(context).snackBarTheme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBuyPowerDescription(),
          SizedBox(height: 2.w),
          _buildBuyPowerData(),
          SizedBox(height: 12.w),
          _buildBuyPowerandWithdrawalCash(),
        ],
      ),
    );
  }

  Widget _buildBuyPowerDescription() {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextWidget(
            'Available for Investing',
            Theme.of(context).textTheme.titleLarge,
          ),
          if (_selectedTabIndex == 0)
            GestureDetector(
              onTap: () {
                // Handle info tap
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                child: AppImages.informationIcon(
                  context,
                  color: Theme.of(context).primaryIconTheme.color,
                  isColor: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBuyPowerData() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 28.w,
      alignment: Alignment.center,
      width: AppWidgetSize.screenWidth(context) - AppWidgetSize.dimen_32,
      child: _getLabelWithRupeeSymbol(
        _availableForInvesting,
        Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.positiveColor(isLight),
            ),
        Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: AppWidgetSize.dimen_24,
              fontWeight: FontWeight.bold,
              color: AppColors.positiveColor(isLight),
            ),
      ),
    );
  }

  Widget _buildBuyPowerandWithdrawalCash() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAccountBalanceDescription(),
              SizedBox(height: 2.w),
              _buildAccountBalanceData(),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWithdrawCashDescription(),
              SizedBox(height: 2.w),
              _buildWithdrawData(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountBalanceDescription() {
    return Padding(
      padding: EdgeInsets.only(top: AppWidgetSize.dimen_6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextWidget(
            'Account Balance',
            Theme.of(context).textTheme.titleLarge,
          ),
          if (_selectedTabIndex == 0)
            InkWell(
              onTap: () {
                // Handle info tap
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                child: AppImages.informationIcon(
                  context,
                  color: Theme.of(context).primaryIconTheme.color,
                  isColor: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAccountBalanceData() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 28.w,
      alignment: Alignment.center,
      width: AppWidgetSize.screenWidth(context) - AppWidgetSize.dimen_32,
      child: _getLabelWithRupeeSymbol(
        _accountBalance,
        Theme.of(context).primaryTextTheme.displaySmall?.copyWith(
              color: AppColors.positiveColor(isLight),
            ),
        Theme.of(context).primaryTextTheme.displaySmall?.copyWith(
              fontSize: AppWidgetSize.dimen_20,
              fontWeight: FontWeight.w500,
              color: AppColors.positiveColor(isLight),
            ),
      ),
    );
  }

  Widget _buildWithdrawCashDescription() {
    return Padding(
      padding: EdgeInsets.only(top: AppWidgetSize.dimen_6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextWidget(
            'Withdrawal Cash',
            Theme.of(context).textTheme.titleLarge,
          ),
          if (_selectedTabIndex == 0)
            GestureDetector(
              onTap: () {
                // Handle info tap
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                child: AppImages.informationIcon(
                  context,
                  color: Theme.of(context).primaryIconTheme.color,
                  isColor: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWithdrawData() {
    return Container(
      height: 28.w,
      alignment: Alignment.center,
      width: AppWidgetSize.screenWidth(context) - AppWidgetSize.dimen_32,
      child: _getLabelWithRupeeSymbol(
        _withdrawalCash,
        Theme.of(context).textTheme.titleSmall,
        Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: AppWidgetSize.dimen_20,
            ),
      ),
    );
  }

  Widget _getLabelWithRupeeSymbol(
    String value,
    TextStyle? rupeeStyle,
    TextStyle? textStyle,
    {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center}
  ) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '₹',
          style: TextStyle(
            fontSize: rupeeStyle?.fontSize ?? textStyle?.fontSize ?? 20.w,
            fontWeight:
                rupeeStyle?.fontWeight ?? textStyle?.fontWeight ?? FontWeight.w500,
            color: rupeeStyle?.color ?? textStyle?.color,
            fontFamily: 'Arial',
          ),
        ),
        SizedBox(width: 2.w),
        CustomTextWidget(
          value,
          textStyle ?? Theme.of(context).textTheme.displaySmall!,
        ),
      ],
    );
  }

  Widget _buildFundDetailWidget() {
    return Container(
      width: AppWidgetSize.screenWidth(context) - AppWidgetSize.dimen_32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppWidgetSize.dimen_10)),
      ),
      height: 128.w,
      child: _buildFundsOptions(),
    );
  }

  Widget _buildFundsOptions() {
    return Column(
      children: [
        _buildFundOptionTile(
          title: 'Arihant Ledger',
          leadingIcon: AppImages.funddetails(context, width: 28.w, height: 28.w),
          onTap: () {
            // Handle Arihant Ledger tap
          },
        ),
        Divider(
          height: 1.w,
          indent: AppWidgetSize.dimen_16,
          endIndent: AppWidgetSize.dimen_16,
          color: Colors.grey,
        ),
        _buildFundOptionTile(
          title: 'Fund History',
          leadingIcon: AppImages.fundhistory(context, width: 28.w, height: 28.w),
          onTap: () {
            // Handle Fund History tap
          },
        ),
      ],
    );
  }

  Widget _buildFundOptionTile({
    required String title,
    required Widget leadingIcon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 63.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            children: [
              SizedBox(width: 28.w, height: 28.w, child: leadingIcon),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextWidget(
                  title,
                  Theme.of(context).textTheme.headlineMedium!,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15.w,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFundDetailsData() {
    // Dummy fund details
    final fundDetails = [
      {'label': 'Collateral Value', 'value': '50,000.00'},
      {'label': 'Payin', 'value': '1,50,000.00'},
      {'label': 'Payout', 'value': '0.00'},
      {'label': 'Opening Balance', 'value': '2,00,000.00'},
      {'label': 'Closing Balance', 'value': '2,00,000.00'},
      {'label': 'Utilized Margin', 'value': '0.00'},
      {'label': 'Available Margin', 'value': '2,00,000.00'},
      {'label': 'Span Margin', 'value': '0.00'},
      {'label': 'Exposure Margin', 'value': '0.00'},
      {'label': 'Pledged stock benefit', 'value': '8,500.00'},
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 16.w,
        bottom: 24.w,
        left: 16.w,
        right: 16.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              indent: AppWidgetSize.dimen_16,
              endIndent: AppWidgetSize.dimen_16,
              color: Colors.grey,
            );
          },
          itemCount: fundDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? AppWidgetSize.dimen_12 : 0,
                bottom: index == (fundDetails.length - 1)
                    ? AppWidgetSize.dimen_12
                    : 0,
              ),
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(
                  vertical: -3,
                  horizontal: -1,
                ),
                title: CustomTextWidget(
                  fundDetails[index]['label']!,
                  Theme.of(context).textTheme.headlineMedium!,
                ),
                trailing: _getLabelWithRupeeSymbol(
                  fundDetails[index]['value']!,
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPledgeButton() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        // Handle pledge tap
      },
      child: Container(
        height: 62.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: isLight
                ? const [
                    Color.fromRGBO(247, 146, 0, 0.08),
                    Color.fromRGBO(247, 146, 0, 0),
                  ]
                : const [
                    Color.fromRGBO(122, 86, 34, 1),
                    Color.fromRGBO(17, 17, 17, 1),
                  ],
          ),
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            AppImages.pledgeCoinImage(context, width: 33.w, height: 33.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    'Pledge & get margin benefit',
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.w),
                  CustomTextWidget(
                    'Get margin against your holdings',
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isLight
                              ? const Color(0xFF434343).withOpacity(0.64)
                              : null,
                        ),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.w,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButtons() {
    return SizedBox(
      height: AppWidgetSize.dimen_64,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double gap = AppWidgetSize.dimen_8;
          if (_selectedTabIndex == 0) {
            final double actionWidth =
                ((constraints.maxWidth - gap) / 2).clamp(0.0, 10000.0);
            return Row(
              children: [
                _buildOutlinedWithdrawButton(
                  width: actionWidth,
                  keyValue: 'withdraw_button',
                ),
                SizedBox(width: gap),
                gradientButtonWidget(
                  onTap: () {
                    // Handle Add Funds tap
                  },
                  width: actionWidth,
                  height: AppWidgetSize.dimen_48,
                  key: const Key('add_funds_button'),
                  context: context,
                  title: 'Add Funds',
                  isGradient: true,
                  bottom: 0,
                  fontsize: 21.w,
                ),
              ],
            );
          }
          return _buildOutlinedWithdrawButton(
            width: constraints.maxWidth,
            keyValue: 'withdraw_button_commodity',
          );
        },
      ),
    );
  }

  Widget _buildOutlinedWithdrawButton({
    required double width,
    required String keyValue,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        // Handle Withdraw tap
      },
      child: Container(
        key: Key(keyValue),
        alignment: Alignment.center,
        width: width,
        height: AppWidgetSize.dimen_48,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppWidgetSize.dimen_30),
          border: Border.all(
            color: isLight ? Theme.of(context).primaryColor : Colors.white70,
            width: 1.2,
          ),
        ),
        child: CustomTextWidget(
          'Withdraw',
          Theme.of(context).textTheme.displaySmall!.copyWith(
                color: isLight ? Theme.of(context).primaryColor : Colors.white,
                fontSize: 21.w,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

