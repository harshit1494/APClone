import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';

class ResearchReinventedScreen extends StatelessWidget {
  const ResearchReinventedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: AppImages.researchBackgroundImg(),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.w, left: 16.w, right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.close, color: Colors.white, size: 22.w),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 5.w),
                          CustomTextWidget(
                            "Your Research. Reinvented.",
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: const Color(0xffC880FE),
                                  fontSize: 22.w,
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          CustomTextWidget(
                            "Unlock exclusive access to high-conviction market insights crafted by our expert desk. Make every move count with precision-driven research built for serious traders and smart investors.",
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                            padding: EdgeInsets.symmetric(vertical: 9.w),
                          ),
                          CustomTextWidget(
                            "SEBI Reg RA: INH000002764",
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                            textAlign: TextAlign.center,
                            padding: EdgeInsets.symmetric(vertical: 9.w),
                          ),
                          CustomTextWidget(
                            "Premium research.\nSeamless experience. Smarter investing",
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.w,
                                ),
                            textAlign: TextAlign.center,
                            padding: EdgeInsets.symmetric(vertical: 9.w),
                          ),
                          _buildPriceCard(context),
                          _buildWhatYouGetCard(context),
                          SizedBox(height: 20.w),
                          Container(
                            width: double.infinity,
                            height: 52.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF79D98E), Color(0xFF35B350)],
                              ),
                              borderRadius: BorderRadius.circular(30.w),
                            ),
                            child: Center(
                              child: CustomTextWidget(
                                'I want access, start free trial',
                                Theme.of(context).primaryTextTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.w),
                          CustomTextWidget(
                            "Maybe I'll do it later",
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.w,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.w),
                        ],
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

  Widget _buildPriceCard(BuildContext context) {
    const Color accentGreen = Color(0xFF36D07B);
    const String period = '3 Months';
    const String price = '₹5,900';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0x1A36D07B),
              Color(0x1910171C),
              Color(0x0A000000),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(
            color: accentGreen.withOpacity(0.9),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: accentGreen.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextWidget(
                period,
                Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextWidget(
                  'FREE',
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: accentGreen,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 4.w),
                CustomTextWidget(
                  '$price/month',
                  Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(0.6),
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12.w,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    const Color accentPurple = Color(0xFFC880FE);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: accentPurple.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Icon(
              icon,
              color: accentPurple,
              size: 18.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  title,
                  Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.w,
                      ),
                ),
                SizedBox(height: 6.w),
                CustomTextWidget(
                  subtitle,
                  Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 11.w,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatYouGetCard(BuildContext context) {
    const Color accentPurple = Color(0xFFC880FE);
    return Padding(
      padding: EdgeInsets.only(top: 2.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(51, 94, 89, 98),
              Color(0x1A000000),
              Color(0x0D36D07B),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              "What You Get",
              Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: accentPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.w,
                  ),
            ),
            SizedBox(height: 8.w),
            _featureItem(
              context,
              icon: Icons.flash_on,
              title: 'Actionable Calls',
              subtitle: 'High-conviction calls with clear entry and exit levels.',
            ),
            _featureItem(
              context,
              icon: Icons.trending_up,
              title: 'Expert Market View',
              subtitle: 'Daily analysis from our research desk for better timing.',
            ),
            _featureItem(
              context,
              icon: Icons.notifications,
              title: 'Timely Alerts',
              subtitle: 'Instant updates so you do not miss key opportunities.',
            ),
            _featureItem(
              context,
              icon: Icons.bar_chart,
              title: 'Smarter Decision Support',
              subtitle: 'Structured insights designed for active traders and investors.',
            ),
          ],
        ),
      ),
    );
  }
}

