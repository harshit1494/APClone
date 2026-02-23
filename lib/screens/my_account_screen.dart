import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/rupee_symbol_widget.dart';
import '../widgets/gradient_button_widget.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/feedback_banner_widget.dart' show FeedbackBannerWidget;

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // Dummy data only - no API calls
  final String _accountName = 'Harsh Chawla';
  final String _userId = 'HC123456';
  final String _accountStatus = 'Ready to Invest';
  final bool _isActivated = true;
  final String _buyPower = '50000.00';
  final String _appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context, isLight),
        body: _buildBody(context, isLight),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isLight) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          // Settings icon
          Container(
            margin: EdgeInsets.only(right: 10.w, left: 12.w),
            child: InkWell(
              onTap: () {
                // Handle settings tap
              },
              child: Icon(
                Icons.settings,
                size: 24.w,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          ),
          // Research icon
          GestureDetector(
            onTap: () {
              // Handle research tap
            },
            child: AppImages.researchLogo(
              context,
              width: 24.w,
              height: 24.w,
            ),
          ),
          // Market indices widget placeholder
          Container(
            margin: EdgeInsets.only(left: AppWidgetSize.dimen_12),
            child: Icon(
              Icons.trending_up,
              size: 24.w,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
          // Notification icon
          Container(
            margin: EdgeInsets.only(right: 10.w, left: 12.w),
            child: GestureDetector(
              onTap: () {
                // Handle notification tap
              },
              child: Icon(
                Icons.notifications_outlined,
                size: 24.w,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          ),
          // Close button
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: AppImages.closeIcon(
              context,
              width: 26.w,
              height: 26.w,
              color: Theme.of(context).primaryIconTheme.color,
              isColor: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isLight) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // Dummy refresh - no API calls
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserDetails(context, isLight),
              _buildFundView(context, isLight),
              _buildMyAccountOptions(context),
              _buildAppVersionAndAboutUs(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context, bool isLight) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 30.w,
        right: 30.w,
        left: 30.w,
      ),
      child: Row(
        children: [
          // Profile Icon - matching reference exactly
          Container(
            width: AppWidgetSize.dimen_60,
            height: AppWidgetSize.dimen_60,
            decoration: BoxDecoration(
              color: AppColors.positiveColor(isLight),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _getInitials(_accountName).toUpperCase(),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: AppWidgetSize.fontSize22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ) ??
                    TextStyle(
                      fontSize: AppWidgetSize.fontSize22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          // User Info
          Expanded(
            child: InkWell(
              onTap: () {
                // Navigate to profile screen
              },
              child: SizedBox(
                width: AppWidgetSize.screenWidth(context) - 120.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: AppWidgetSize.screenWidth(context) * 0.5,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: CustomTextWidget(
                                _accountName,
                                Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      _isActivated ? Icons.check_circle : Icons.cancel,
                                      size: 12.w,
                                      color: _isActivated
                                          ? AppColors.positiveColor(isLight)
                                          : AppColors.negativeColor,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: AppWidgetSize.dimen_8,
                                      ),
                                      child: CustomTextWidget(
                                        _accountStatus,
                                        Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontSize: AppWidgetSize.fontSize12,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Theme.of(context).colorScheme.primary,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: AppWidgetSize.dimen_8),
                                  child: CustomTextWidget(
                                    _userId,
                                    Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: AppWidgetSize.fontSize12,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundView(BuildContext context, bool isLight) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.w, right: 30.w, left: 30.w),
      child: Card(
        elevation: 5,
        color: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppWidgetSize.dimen_10)),
          side: BorderSide(
            width: 0.5,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(AppWidgetSize.dimen_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Buy Power with Rupee Symbol
              SizedBox(
                width: AppWidgetSize.screenWidth(context) * 0.7,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getRupeeSymbol(
                        context,
                        Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: AppWidgetSize.fontSize22,
                              color: AppColors.positiveColor(isLight),
                              fontWeight: FontWeight.w600,
                            ) ??
                            TextStyle(
                              fontSize: AppWidgetSize.fontSize22,
                              color: AppColors.positiveColor(isLight),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      CustomTextWidget(
                        _buyPower,
                        Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: AppWidgetSize.fontSize22,
                              color: AppColors.positiveColor(isLight),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // Available for Investing
              Padding(
                padding: EdgeInsets.only(top: 10.w, bottom: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      'Available for Investing',
                      Theme.of(context).textTheme.titleLarge,
                    ),
                    InkWell(
                      onTap: () {
                        // Show info dialog
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: AppImages.informationIcon(
                          context,
                          width: AppWidgetSize.dimen_24,
                          height: AppWidgetSize.dimen_24,
                          color: Theme.of(context).primaryIconTheme.color,
                          isColor: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Withdraw and Add Funds buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gradientButtonWidget(
                    onTap: () {
                      // Handle withdraw
                    },
                    width: 120.w,
                    key: const Key('withdrawButton'),
                    context: context,
                    bottom: 0,
                    title: 'Withdraw',
                    isGradient: false,
                    borderColor: AppColors.positiveColor(isLight),
                    backgroundcolor: Theme.of(context).scaffoldBackgroundColor,
                    inactiveTextColor: AppColors.positiveColor(isLight),
                    height: AppWidgetSize.dimen_50,
                  ),
                  SizedBox(width: 15.w),
                  gradientButtonWidget(
                    onTap: () {
                      // Handle add funds
                    },
                    width: 120.w,
                    key: const Key('addFundsButton'),
                    context: context,
                    bottom: 0,
                    title: 'Add Funds',
                    isGradient: true,
                    height: AppWidgetSize.dimen_50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyAccountOptions(BuildContext context) {
    final options = _getMyAccountOptions(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_30),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_1),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return options[index];
        },
      ),
    );
  }

  List<Widget> _getMyAccountOptions(BuildContext context) {
    return [
      ListTileWidget(
        title: 'Bank Accounts',
        subtitle: 'Bank details',
        leadingImage: AppImages.bankAccount(context),
        onTap: () {
          // Navigate to bank accounts
        },
      ),
      ListTileWidget(
        title: 'IPO',
        subtitle: 'Invest online in IPO',
        leadingImage: AppImages.ipoIcon(context),
        onTap: () {
          // Navigate to IPO
        },
      ),
      ListTileWidget(
        title: 'Research Calls',
        subtitle: 'Research stock ideas from experts',
        leadingImage: AppImages.researchLogo(
          context,
          width: 24.w,
          height: 24.w,
        ),
        onTap: () {
          // Navigate to research
        },
      ),
      ListTileWidget(
        title: 'Smart Reports',
        subtitle: 'Your trading reports',
        leadingImage: AppImages.reports(context),
        onTap: () {
          // Navigate to reports
        },
      ),
      ListTileWidget(
        title: 'News',
        subtitle: 'Market news',
        leadingImage: AppImages.megaPhone(context, width: 25.w, height: 25.w),
        onTap: () {
          // Navigate to news
        },
      ),
      ListTileWidget(
        title: 'My Alerts',
        subtitle: 'Manage alerts',
        leadingImage: AppImages.alertMyAccount(context),
        onTap: () {
          // Navigate to alerts
        },
      ),
      ListTileWidget(
        title: 'Links',
        subtitle: '',
        leadingImage: Icon(
          Icons.link,
          size: 24.w,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        onTap: () {
          // Navigate to links
        },
      ),
      ListTileWidget(
        title: 'Need Help',
        subtitle: 'FAQ',
        leadingImage: AppImages.needHelp(context),
        onTap: () {
          // Navigate to help
        },
      ),
      ListTileWidget(
        title: 'Switch Account',
        subtitle: '',
        leadingImage: AppImages.switchAcc(context),
        onTap: () {
          // Handle switch account
        },
      ),
      ListTileWidget(
        title: 'Logout',
        subtitle: '',
        leadingImage: AppImages.logout(context),
        onTap: () {
          _showLogoutDialog(context);
        },
        hideDivider: true,
      ),
      // Enjoying the App - Feedback Banner
      Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: const FeedbackBannerWidget(),
      ),
    ];
  }

  Widget _buildAppVersionAndAboutUs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppWidgetSize.dimen_35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Navigate to about us
            },
            child: Row(
              children: [
                CustomTextWidget(
                  'About Us',
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.w,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ],
            ),
          ),
          CustomTextWidget(
            'App v$_appVersion',
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppWidgetSize.fontSize12,
                ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
      builder: (BuildContext bct) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          padding: EdgeInsets.all(AppWidgetSize.dimen_30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextWidget(
                'Logout',
                Theme.of(context).textTheme.displaySmall,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppWidgetSize.dimen_20,
                  bottom: 20.h,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextWidget(
                    'Are you sure you want to logout?',
                    Theme.of(context).textTheme.headlineMedium ??
                    Theme.of(context).textTheme.titleMedium!,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // Handle logout
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        'Proceed',
                        style: Theme.of(context).primaryTextTheme.headlineMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.trim().split(RegExp(r' +'));
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }
}
