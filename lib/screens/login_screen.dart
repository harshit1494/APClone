import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_images.dart';
import '../utils/app_widget_size.dart';
import '../widgets/acml_text_field.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/gradient_button_widget.dart';

class LoginScreen extends StatefulWidget {
  final String? userName;
  final bool verifiedUid;

  const LoginScreen({
    Key? key,
    this.userName,
    this.verifiedUid = false,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userIdController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  bool hidePassword = true;
  bool isMobile = true;
  bool enablePasswordIcon = false;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocus.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        leadingWidth: 40.w,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: widget.verifiedUid
            ? Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : null,
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Theme.of(context).primaryTextTheme.labelLarge!.color,
          size: 30,
        ),
        actions: [
          _buildTryDemoButton(isLight),
        ],
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: proceedButton(),
      body: Padding(
        padding: EdgeInsets.only(bottom: 70.0.w),
        child: _buildBody(isLight),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBottomWidget(),
            _buildNeedHelpWidget(isLight),
          ],
        ),
      ),
    );
  }

  Widget _buildTryDemoButton(bool isLight) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, top: 8.h, bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          // Try Demo action - no implementation
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onSurface,
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.w),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 18.w,
              ),
              SizedBox(width: 6.w),
              Text(
                'Try Demo',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.w,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget proceedButton() {
    return Opacity(
      opacity: _userIdController.text.isEmpty ||
              (isMobile && _userIdController.text.length < 10) ||
              (widget.verifiedUid && _passwordController.text.isEmpty)
          ? 0.3
          : 1,
      child: gradientButtonWidget(
        onTap: () {
          // No API implementation - just UI
        },
        bottom: 0,
        width: AppWidgetSize.dimen_280,
        key: const Key('loginSubmitButton'),
        context: context,
        title: 'Proceed',
        isGradient: true,
      ),
    );
  }

  Widget _buildBody(bool isLight) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              bottom: AppWidgetSize.dimen_10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.verifiedUid ? 24.w : 0.h,
                  ),
                  child: isLight
                      ? AppImages.arihantNewLogoLight(
                          context,
                          height: 40.w,
                          width: AppWidgetSize.dimen_240,
                        )
                      : AppImages.arihantNewLogoDark(
                          context,
                          height: 40.w,
                          width: AppWidgetSize.dimen_240,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.userName != null ? 60.h : 70.h,
                  ),
                  child: CustomTextWidget(
                    widget.userName != null ? 'Welcome back' : 'Welcome to Arihant',
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: widget.userName != null ? 37.w : 23.w,
                    ),
                    textOverflow: TextOverflow.visible,
                    textAlign: TextAlign.start,
                  ),
                ),
                if (!isMobile && !widget.verifiedUid)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: AppWidgetSize.dimen_35,
                      top: AppWidgetSize.dimen_20,
                    ),
                    child: InkWell(
                      onTap: () {
                        // Google sign in - no implementation
                      },
                      child: Material(
                        elevation: 3.0,
                        shadowColor: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(8.w)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.w,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.w),
                            ),
                            border: Border.all(
                              width: AppWidgetSize.dimen_1,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              AppImages.googleLogo(
                                context,
                                height: 21.w,
                                width: 21.w,
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: CustomTextWidget(
                                  'Continue with Google',
                                  Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textOverflow: TextOverflow.visible,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_sharp, size: 18.w),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isMobile) SizedBox(height: 6.w),
                if (!isMobile && !widget.verifiedUid)
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppWidgetSize.dimen_16,
                      right: 35.w,
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        'or',
                        Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: isLight
                              ? const Color(0xFF434343).withOpacity(0.64)
                              : const Color(0xFFFFFFFF).withOpacity(0.64),
                        ),
                      ),
                    ),
                  ),
                if (widget.userName != null)
                  Padding(
                    padding: EdgeInsets.only(top: 0.h),
                  child: CustomTextWidget(
                    widget.userName ?? '',
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 37.w,
                    ),
                    textOverflow: TextOverflow.visible,
                    textAlign: TextAlign.start,
                  ),
                  ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(
              left: AppWidgetSize.dimen_35,
              right: AppWidgetSize.dimen_35,
              bottom: AppWidgetSize.dimen_60,
              top: AppWidgetSize.dimen_10,
            ),
            child: buildInputSection(isLight),
          ),
        ],
      ),
    );
  }

  Widget buildInputSection(bool isLight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!widget.verifiedUid)
          usernameField()
        else
          Column(
            children: [
              passwordfield(),
              Container(
                padding: EdgeInsets.only(top: AppWidgetSize.dimen_15),
                alignment: Alignment.topRight,
                child: GestureDetector(
                  key: const Key('forgotPassword'),
                  onTap: () {
                    // Forgot password - no implementation
                  },
                  child: Text(
                    'Forgot Password',
                    style: Theme.of(context).primaryTextTheme.titleLarge!,
                  ),
                ),
              ),
            ],
          ),
        if (!widget.verifiedUid)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMobile)
                Padding(
                  padding: EdgeInsets.only(top: AppWidgetSize.dimen_16),
                  child: Center(
                    child: CustomTextWidget(
                      'or',
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: isLight
                            ? const Color(0xFF434343).withOpacity(0.64)
                            : const Color(0xFFFFFFFF).withOpacity(0.64),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                  top: isMobile ? AppWidgetSize.dimen_16 : 32.w,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMobile = !isMobile;
                        _userIdController.clear();
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: CustomTextWidget(
                      isMobile
                          ? 'Login with client ID/ email'
                          : 'Login with Mobile Number',
                      Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: AppWidgetSize.dimen_18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  ACMLTextField usernameField() {
    return ACMLTextField(
      hint: isMobile
          ? 'Enter 10 digit mobile number'
          : 'Enter your client ID/ email',
      label: isMobile ? ' Mobile number ' : 'Client ID/ email',
      textEditingController: _userIdController,
      focusNode: usernameFocusNode,
      autofocus: false,
      isPrefix: isMobile,
      fieldKey: const Key('userNameTextField'),
      onFieldSubmitted: (s) {
        passwordFocus.requestFocus();
      },
      onChange: ((value) => setState(() {})),
      inputFormatters: isMobile
          ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]
          : [LengthLimitingTextInputFormatter(50)],
      maxLength: 50,
    );
  }

  ACMLTextField passwordfield() {
    return ACMLTextField(
      label: 'Password',
      hint: 'Enter your password',
      isPrefix: false,
      textEditingController: _passwordController,
      focusNode: passwordFocus,
      fieldKey: const Key('passwordTextField'),
      onChange: (String text) {
        if (text.isNotEmpty) {
          setState(() {
            enablePasswordIcon = true;
          });
        } else {
          setState(() {
            enablePasswordIcon = false;
          });
        }
      },
      suffixIcon: suffixIconPassword(),
      obscure: hidePassword,
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
    );
  }

  Widget suffixIconPassword() {
    return enablePasswordIcon
        ? GestureDetector(
            key: const Key('eyeIcon'),
            onTap: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(AppWidgetSize.dimen_8),
              child: hidePassword
                  ? AppImages.eyeOpenIcon(
                      context,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : AppImages.eyeClosedIcon(
                      context,
                      color: Theme.of(context).iconTheme.color,
                    ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(AppWidgetSize.dimen_8),
            width: 20.w,
          );
  }

  Widget _buildBottomWidget() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppWidgetSize.dimen_1),
                  child: CustomTextWidget(
                    'By proceeding, I agree to the ',
                    Theme.of(context).primaryTextTheme.labelSmall!.copyWith(fontSize: 14.w),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: !widget.verifiedUid ? 20.h : 40.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Terms & Conditions - no implementation
                    },
                    child: CustomTextWidget(
                      'Terms & Conditions',
                      Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                        fontSize: 14.w,
                        decoration: TextDecoration.underline,
                      ),
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

  Widget _buildNeedHelpWidget(bool isLight) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Need help - no implementation
              },
              child: CustomTextWidget(
                'Need Help?',
                Theme.of(context).primaryTextTheme.headlineSmall!,
              ),
            ),
          ),
          if (!widget.verifiedUid)
            Padding(
              padding: EdgeInsets.only(top: 20.w, bottom: 8.w),
              child: Divider(thickness: 1.w),
            ),
          if (!widget.verifiedUid)
            CustomTextWidget(
              'New to Arihant? Open an account online in minutes',
              Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                fontSize: 11.w,
                color: isLight
                    ? const Color(0xFF434343).withOpacity(0.64)
                    : const Color(0xFFFFFFFF).withOpacity(0.64),
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
