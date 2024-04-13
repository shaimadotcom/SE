
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnjava/data/model/body/register_model.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/providers/auth_provider.dart';
import 'package:learnjava/providers/localization_provider.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/screens/auth/login_screen.dart';
import 'package:learnjava/screens/auth/register_screen.dart';
import 'package:learnjava/screens/base_widgets/customTextFieldContainer.dart';
import 'package:learnjava/screens/base_widgets/passwordHideShowButton.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:learnjava/utill/color_resources.dart';
import 'package:learnjava/utill/custom_themes.dart';
import 'package:learnjava/utill/dimensions.dart';
import 'package:learnjava/utill/images.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  GlobalKey<FormState>? _formKey;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<double> _patterntAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ),
  );

  late final Animation<double> _formAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ),
  );

  final TextEditingController _userNameTextEditingController = TextEditingController(text: null); //default grNumber
  final TextEditingController _nameTextEditingController = TextEditingController(text: null); //default grNumber

  final TextEditingController _passwordTextEditingController = TextEditingController(text: null); //default password

  bool _hidePassword = true;
  RegisterModel register = RegisterModel();
  @override
  void initState() {
    super.initState();
    _animationController.forward();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _userNameTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      String password = _passwordTextEditingController.text.trim();
      // String confirmPassword = _confirmPasswordController.text.trim();

      // if (firstName.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('first_name_field_is_required', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }else if (lastName.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('last_name_field_is_required', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // } else if (email.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
      //     backgroundColor: Colors.red,
      //   ));
      // }else
        if (_nameTextEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else
      if (_userNameTextEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('USER_NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.primaryOrangeColor,
        ));
      } else  if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.primaryOrangeColor,
        ));
      }
      else {
        // register.fName = _firstNameController.text;
        // register.lName = _lastNameController.text;
        register.name = _nameTextEditingController.text;
        register.password = _passwordTextEditingController.text;
        register.username=_userNameTextEditingController.text;
        await Provider.of<AuthProvider>(context, listen: false).registration(register, route);
      }
    }
  }

  route(bool isRoute, String? token, String? errorMessage) async {
    if (isRoute) {
        await Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
        await Provider.of<SplashProvider>(context, listen: false).initConfig(context);
        if (context.mounted) {}
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
        _passwordTextEditingController.clear();
        _userNameTextEditingController.clear();
        _nameTextEditingController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(errorMessage!, context) ?? errorMessage), backgroundColor: ColorResources.primaryOrangeColor));
    }
  }


  void _signInStudent() {
    if (_userNameTextEditingController.text.trim().isEmpty) {
      AppConstants.showCustomSnackBar(
        context: context,
        errorMessage: getTranslated("please Enter User Name", context) ?? "please Enter User Name",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      return;
    }
    if (_nameTextEditingController.text.trim().isEmpty) {
      AppConstants.showCustomSnackBar(
        context: context,
        errorMessage: getTranslated("please Enter Name", context) ?? "please Enter  Name",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    if (_passwordTextEditingController.text.trim().isEmpty) {
      AppConstants.showCustomSnackBar(
        context: context,
        errorMessage: getTranslated("please Enter Passsword", context) ?? "please Enter Password",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
  }

  Widget _buildUpperPattern() {
    return Align(
      alignment:Provider.of<LocalizationProvider>(context,listen: false).locale.languageCode=="ar"? AlignmentDirectional.topStart:AlignmentDirectional.topEnd,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
          position: _patterntAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero),
          ),
          child: Image.asset(Images.upper),
        ),
      ),
    );
  }

  Widget _buildLowerPattern() {
    return Align(
      alignment:Provider.of<LocalizationProvider>(context,listen: false).locale.languageCode=="ar"? AlignmentDirectional.bottomEnd:AlignmentDirectional.bottomStart,

      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
          position: _patterntAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero),
          ),
          child: Image.asset(Images.lower),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _formAnimation,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * (0.075),
                right: MediaQuery.of(context).size.width * (0.075),
                top: MediaQuery.of(context).size.height * (0.15),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * (0.5),
                          //height: MediaQuery.of(context).size.height * (0.5),
                          child: Image.asset(
                            Images.loginLogo,
                            height: 100,
                          )),
                    ),
                    Text(
                      getTranslated("Lets Sign Up", context) ?? "Lets Sign Up",
                      style: const TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${getTranslated("Are You ready?", context) ?? "Are You ready?"} \n${getTranslated("Create Your Account!", context) ?? "Create Your Account!"}",
                      style: TextStyle(
                        fontSize: 24.0,
                        height: 1.5,
                        color: ColorResources.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFieldContainer(
                      hideText: false,
                      hintTextKey: getTranslated("Name", context) ?? "Name",
                      bottomPadding: 0,
                      textEditingController: _nameTextEditingController,
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          Images.user,
                          colorFilter: ColorFilter.mode(
                            ColorResources.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFieldContainer(
                      hideText: false,
                      hintTextKey: "User Name",
                      bottomPadding: 0,
                      textEditingController: _userNameTextEditingController,
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          Images.user,
                          colorFilter: ColorFilter.mode(
                            ColorResources.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFieldContainer(
                      textEditingController: _passwordTextEditingController,
                      suffixWidget: PasswordHideShowButton(
                        hidePassword: _hidePassword,
                        onTap: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                      hideText: _hidePassword,
                      hintTextKey: getTranslated("PASSWORD", context) ?? "Password",
                      bottomPadding: 0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      // child: BlocConsumer<SignInCubit, SignInState>(
                      //   listener: (context, state) {
                      //     if (state is SignInSuccess) {
                      //       //
                      //       context.read<AuthCubit>().authenticateUser(
                      //         jwtToken: state.jwtToken,
                      //         isStudent: state.isStudentLogIn,
                      //         parent: state.parent,
                      //         student: state.student,
                      //       );
                      //       //somehow user logs out, the login will set count to 0
                      //       SettingsRepository().setNotificationCount(0);
                      //       Navigator.of(context).pushNamedAndRemoveUntil(
                      //         Routes.home,
                      //             (Route<dynamic> route) => false,
                      //       );
                      // } else if (state is SignInFailure) {
                      //   UiUtils.showCustomSnackBar(
                      //     context: context,
                      //     errorMessage: UiUtils.getErrorMessageFromErrorCode(
                      //       context,
                      //       state.errorMessage,
                      //     ),
                      //     backgroundColor:
                      //     Theme.of(context).colorScheme.error,
                      //   );
                      // }
                      //},
                      // builder: (context, state) {
                      //   return
                        child: Provider.of<AuthProvider>(context).isLoading
                            ? Container(
                            height: height * 0.07,
                            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorResources.primaryColor,
                                ),
                              ),
                            ))
                            :
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0), //
                            alignment: Alignment.center,
                            height: 55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ColorResources.primaryColor,
                              border: Border.all(
                                color: ColorResources.primaryColor,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextButton(
                              onPressed: () {
                                addUser();
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(getTranslated('SignUp', context) ?? "Sign up", style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeLarge)),
                              ),
                            ))),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: ColorResources.primaryColor,
                                ),
                                text: getTranslated(
                                  "Have Account?",
                                  context,
                                ) ??
                                    "Have Account?",
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: ColorResources.primaryOrangeColor,
                                ),
                                text: getTranslated(
                                  "Login",
                                  context,
                                ) ??
                                    "Login",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.035),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildLowerPattern(),
          _buildUpperPattern(),
          _buildLoginForm(),
        ],
      ),
    );
  }
}
