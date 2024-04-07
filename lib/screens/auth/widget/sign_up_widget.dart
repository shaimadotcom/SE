// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'code_picker_widget.dart';
// import 'otp_verification_screen.dart';
//
// class SignUpWidget extends StatefulWidget {
//   const SignUpWidget({Key? key}) : super(key: key);
//
//   @override
//   SignUpWidgetState createState() => SignUpWidgetState();
// }
//
// class SignUpWidgetState extends State<SignUpWidget> {
//   // final TextEditingController _firstNameController = TextEditingController();
//   // final TextEditingController _lastNameController = TextEditingController();
//
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   GlobalKey<FormState>? _formKey;
//
//   // final FocusNode _fNameFocus = FocusNode();
//   // final FocusNode _lNameFocus = FocusNode();
//
//   final FocusNode _phoneFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();
//
//   RegisterModel register = RegisterModel();
//   bool isMobileVerified = false;
//
//   addUser() async {
//     if (_formKey!.currentState!.validate()) {
//       _formKey!.currentState!.save();
//       isMobileVerified = true;
//
//       // String firstName = _firstNameController.text.trim();
//       // String lastName = _lastNameController.text.trim();
//       String phone = _phoneController.text.trim();
//       String phoneNumber = _countryDialCode! + _phoneController.text.trim();
//       String password = _passwordController.text.trim();
//       String confirmPassword = _confirmPasswordController.text.trim();
//
//       // if (firstName.isEmpty) {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(getTranslated('first_name_field_is_required', context)!),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // }else if (lastName.isEmpty) {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(getTranslated('last_name_field_is_required', context)!),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // } else if (email.isEmpty) {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // }else
//       //   if (EmailChecker.isNotValid(email)) {
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text(getTranslated('enter_valid_email_address', context)!),
//       //     backgroundColor: Colors.red,
//       //   ));
//       // } else
//       if (phone.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else if (!RegExp(r'^9\d{8}$').hasMatch(phone)) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('ENTER_Valid_MOBILE_NUMBER', context) ?? "MOBILE NUMBER Must Be 9xx xxx xxx"),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else if (password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else if (confirmPassword.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else if (password != confirmPassword) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else if (!Provider.of<AuthProvider>(context, listen: false).acceptPolicy!) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('policy_must_accept', context)??"You must agree to the Privacy Policy and Terms of Use"),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       }
//
//       else {
//         // register.fName = _firstNameController.text;
//         // register.lName = _lastNameController.text;
//         register.mobile = phoneNumber;
//         register.password = _passwordController.text;
//         await Provider.of<AuthProvider>(context, listen: false).registration(register, route);
//       }
//     } else {
//       isMobileVerified = false;
//     }
//   }
//
//   route(bool isRoute, String? token, String? errorMessage, int? testcode) async {
//     logger.i(testcode);
//     String phone = _countryDialCode! + _phoneController.text.trim();
//     if (isRoute) {
//       if (Provider.of<SplashProvider>(context, listen: false).configModel!.phoneVerification ?? false) {
//         Provider.of<AuthProvider>(context, listen: false).checkPhone(phone, token!).then((value) async {
//           if (value.isSuccess) {
//             Provider.of<AuthProvider>(context, listen: false).updatePhone(phone);
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => VerificationScreen(
//                           token,
//                           phone,
//                           testcode: testcode,
//                         )),
//                 (route) => false);
//           }
//         });
//       } else {
//         await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
//         logger.i(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.toJson());
//         if (context.mounted) {}
//         //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
//         _passwordController.clear();
//         // _firstNameController.clear();
//         // _lastNameController.clear();
//         _phoneController.clear();
//         _confirmPasswordController.clear();
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(errorMessage!, context) ?? errorMessage), backgroundColor: ColorResources.primaryOrangeColor));
//     }
//   }
//
//   String? _countryDialCode = "+963";
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<AuthProvider>(context, listen: false).setLoadingValue(false);
//     Provider.of<SplashProvider>(context, listen: false).configModel;
//     _countryDialCode = CountryCode.fromCountryCode(Provider.of<SplashProvider>(context, listen: false).configModel!.countryCode ?? "SY").dialCode;
//     _formKey = GlobalKey<FormState>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return ListView(
//       padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
//       children: [
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // for first and last name
//               // Container(
//               //   margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault),
//               //   child: Row(
//               //     children: [
//               //       Expanded(child: CustomTextField(
//               //         hintText: getTranslated('FIRST_NAME', context),
//               //         textInputType: TextInputType.name,
//               //         focusNode: _fNameFocus,
//               //         nextNode: _lNameFocus,
//               //         isPhoneNumber: false,
//               //         capitalization: TextCapitalization.words,
//               //         controller: _firstNameController,)),
//               //       const SizedBox(width: Dimensions.paddingSizeDefault),
//               //
//               //
//               //       Expanded(child: CustomTextField(
//               //         hintText: getTranslated('LAST_NAME', context),
//               //         focusNode: _lNameFocus,
//               //         nextNode: _emailFocus,
//               //         capitalization: TextCapitalization.words,
//               //         controller: _lastNameController,)),
//               //     ],
//               //   ),
//               // ),
//
//               // Container(
//               //   margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
//               //       top: Dimensions.marginSizeSmall),
//               //   child: CustomTextField(
//               //     hintText: getTranslated('ENTER_YOUR_EMAIL', context),
//               //     focusNode: _emailFocus,
//               //     nextNode: _phoneFocus,
//               //     textInputType: TextInputType.emailAddress,
//               //     controller: _emailController,
//               //   ),
//               // ),
//
//               Container(
//                 margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeExtraLarge),
//                 child: Row(children: [
//                   Expanded(
//                       child: CustomTextField(
//                     hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
//                     controller: _phoneController,
//                     focusNode: _phoneFocus,
//                     nextNode: _passwordFocus,
//                     isPhoneNumber: true,
//                     textInputAction: TextInputAction.next,
//                     textInputType: TextInputType.phone,
//                   )),
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: CodePickerWidget(
//                       // onChanged: (CountryCode countryCode) {
//                       //   _countryDialCode = countryCode.dialCode;
//                       // },
//                       enabled: false,
//                       initialSelection: _countryDialCode,
//                       favorite: [_countryDialCode!],
//                       showDropDownButton: false,
//                       padding: EdgeInsets.zero,
//                       showFlagMain: true,
//                       textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeExtraLarge),
//                 child: CustomPasswordTextField(
//                   hintTxt: getTranslated('PASSWORD', context),
//                   controller: _passwordController,
//                   focusNode: _passwordFocus,
//                   nextNode: _confirmPasswordFocus,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeExtraLarge),
//                 child: CustomPasswordTextField(
//                   hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
//                   controller: _confirmPasswordController,
//                   focusNode: _confirmPasswordFocus,
//                   textInputAction: TextInputAction.done,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//             margin: const EdgeInsets.only(right: Dimensions.marginSizeSmall),
//             child: Row(
//               children: [
//                 Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) => Checkbox(
//                     checkColor: ColorResources.white,
//                     activeColor: ColorResources.primaryColor,
//                     value: authProvider.acceptPolicy,
//                     onChanged: authProvider.updateAcceptPolicy,
//                   ),
//                 ),
//                 //Text(getTranslated('policy_check', context)??"Agree On ", style: titilliumRegular),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: getTranslated('policy_check', context)??"Agree On ",
//                         style: DefaultTextStyle.of(context).style,
//                       ),
//
//                       TextSpan(
//                         text: getTranslated('policy', context)??"policy",
//                         style: TextStyle(color: ColorResources.getPrimaryOrange(context),fontWeight: FontWeight.w500,decoration: TextDecoration.underline),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () async {
//                             // const url = 'https://your-policy-url.com';
//                             // if (await canLaunchUrl(Uri(host: url))) {
//                             //   await launchUrl(Uri(host: url));
//                             // } else {
//                             //   throw 'Could not launch $url';
//                             // }
//                             Navigator.push(context, MaterialPageRoute(builder: (_) =>const PrivacyScreen()));
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//         Provider.of<AuthProvider>(context).isLoading
//             ? Container(
//                 height: height * 0.07,
//                 margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
//                 child: const Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       ColorResources.primaryColor,
//                     ),
//                   ),
//                 ))
//             : Container(
//                 height: height * 0.07,
//                 margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: ColorResources.getPrimary(context),
//                 ),
//                 child: TextButton(
//                   onPressed: () {
//                     addUser();
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     child: Text(getTranslated('SignUp', context) ?? "SignUp", style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }
// }
