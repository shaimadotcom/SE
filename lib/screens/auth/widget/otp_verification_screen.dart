// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:musafer/data/model/body/login_model.dart';
// import 'package:musafer/localization/language_constrants.dart';
// import 'package:musafer/provider/auth_provider.dart';
// import 'package:musafer/provider/profile_provider.dart';
// import 'package:musafer/provider/splash_provider.dart';
// import 'package:musafer/utill/app_constants.dart';
// import 'package:musafer/utill/color_resources.dart';
// import 'package:musafer/utill/custom_themes.dart';
// import 'package:musafer/utill/dimensions.dart';
// import 'package:musafer/utill/images.dart';
// import 'package:musafer/view/basewidget/button/custom_button.dart';
// import 'package:musafer/view/basewidget/show_custom_snakbar.dart';
// import 'package:musafer/view/screen/auth/auth_screen.dart';
// import 'package:musafer/view/screen/auth/main_Auth_screen.dart';
// import 'package:musafer/view/screen/dashboard/dashboard_screen.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
//
// class VerificationScreen extends StatefulWidget {
//   final String tempToken;
//   final String mobileNumber;
//   final bool fromForgetPassword;
//   final int? testcode;
//   final String? password;
//   const VerificationScreen(this.tempToken, this.mobileNumber, {Key? key, this.fromForgetPassword = false,this.testcode,this.password}) : super(key: key);
//
//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }
//
// class _VerificationScreenState extends State<VerificationScreen> {
//   Timer? _timer;
//   int? _seconds = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _seconds = Provider.of<AuthProvider>(context, listen: false).resendTime;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _seconds = _seconds! - 1;
//       if(_seconds == 0) {
//         timer.cancel();
//         _timer?.cancel();
//       }
//       setState(() {});
//     });
//   }
//   LoginModel loginBody = LoginModel();
//   void loginUser() async {
//       //String phone = widget.mobileNumber;
//       String phoneNumber =widget.mobileNumber;
//       String password = widget.password??"";
//         loginBody.mobile = phoneNumber;
//         loginBody.password = password;
//         await Provider.of<AuthProvider>(context, listen: false).login(loginBody, route);
//   }
// route(bool isRoute, String? token, String? temporaryToken, String? errorMessage,bool? verified,int newCode) async {
//   if (isRoute) {
//     await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
//     if(context.mounted){}
//     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
//     //}
//   }else
//   {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(errorMessage!, context)??errorMessage ), backgroundColor: ColorResources.primaryOrangeColor));
//   }
// }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     int minutes = (_seconds! / 60).truncate();
//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//
//     return Scaffold(
//       body: SafeArea(
//         child: Scrollbar(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Center(
//               child: SizedBox(
//                 width: width,
//                 child: Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) => Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 55),
//                       Image.asset(Images.login, width: 100, height: 100,),
//                       const SizedBox(height: 40),
//
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25),
//                         child: Center(child: Text(
//                         '${getTranslated('please_enter_6_digit_code', context)}',
//                           textAlign: TextAlign.center,)),),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25),
//                         child: Center(child: Directionality(
//                           textDirection: TextDirection.ltr,
//                           child: Text(
//                             widget.mobileNumber,
//                             textAlign: TextAlign.center,),
//                         )),),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
//                         child: Center(child: Directionality(
//                           textDirection: TextDirection.ltr,
//                           child: Text('Your Code:${widget.testcode??""}',
//                             textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 16,color: ColorResources.primaryOrangeColor),
//                           ),
//                         )),),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
//                         child: Directionality(
//                           textDirection: TextDirection.ltr,
//                           child: PinCodeTextField(
//                             length: 6,
//                             appContext: context,
//                             obscureText: false,
//                             showCursor: true,
//                             keyboardType: TextInputType.number,
//                             animationType: AnimationType.fade,
//                             cursorColor: ColorResources.getPrimary(context),
//                             cursorHeight: 20,
//                             cursorWidth: 1,
//                             enablePinAutofill: true,
//                             textStyle: const TextStyle(color: ColorResources.white),
//                             // onCompleted:  (text) {
//                             //   logger.i('finish $text');
//                             // },
//                             pinTheme: PinTheme(
//                               shape: PinCodeFieldShape.box,
//                               fieldHeight: height*0.06,
//                               fieldWidth: width*0.12,
//                               selectedColor: ColorResources.getPrimary(context),
//                               selectedFillColor: ColorResources.getSearchBg(context),
//                               inactiveFillColor: ColorResources.white,
//                               inactiveColor: ColorResources.getPrimary(context),
//                               activeColor: ColorResources.primaryOrangeColor,
//                               activeFillColor: ColorResources.primaryOrangeColor//getSearchBg(context),
//                             ),
//                             animationDuration: const Duration(milliseconds: 300),
//                             backgroundColor: Colors.transparent,
//                             enableActiveFill: true,
//                             onChanged: authProvider.updateVerificationCode,
//                             beforeTextPaste: (text) {
//                               logger.i('before $text');
//                               return true;
//                             },
//                           ),
//                         ),
//                       ),
//
//                       if(_seconds! <= 0)
//                       Column(children: [
//                         Center(child: Text(getTranslated('i_didnt_receive_the_code', context)!,)),
//
//
//                         Center(
//                           child: InkWell(
//                             onTap: () {
//                               if(widget.fromForgetPassword){
//                                 // Provider.of<AuthProvider>(context, listen: false).forgetPassword(widget.mobileNumber).then((value) {
//                                 //   if (value.isSuccess) {
//                                 //     _startTimer();
//                                 //     showCustomSnackBar('Resent code successful', context, isError: false);
//                                 //   } else {
//                                 //     showCustomSnackBar(value.message, context);
//                                 //   }
//                                 // });
//
//                               }
//                               else{
//                                 Provider.of<AuthProvider>(context, listen: false).checkPhone(widget.mobileNumber,widget.tempToken, fromResend: true).then((value) {
//                                   if (value.isSuccess) {
//                                     _startTimer();
//                                     showCustomSnackBar(getTranslated('Resent_code_successful', context)??'Resent code successful' , context, isError: false);
//                                   } else {
//                                     showCustomSnackBar(value.message, context);
//                                   }
//                                 });
//                               }
//
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                               child: Text(getTranslated('resend_code', context)!,
//                                 style: robotoBold.copyWith(color: ColorResources.primaryColor),),),
//                           ),
//                         ),
//                       ],),
//
//
//
//
//
//                       if(_seconds! > 0)
//                         Text('${getTranslated('resend_code', context)} ${getTranslated('after', context)} ${_seconds! > 0 ? '$minutesStr:${_seconds! % 60}' : ''} ${getTranslated('sec', context)}'),
//
//
//
//                        SizedBox(height: height*0.075),
//
//                       authProvider.isEnableVerificationCode ? !authProvider.isPhoneNumberVerificationButtonLoading ?
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
//                         child: CustomButton(
//                           buttonText: getTranslated('verify', context),
//
//                           onTap: () {
//                             bool phoneVerification = Provider.of<SplashProvider>(context,listen: false).configModel!.forgetPasswordVerification =='phone';
//                             if(phoneVerification && widget.fromForgetPassword){
//                               Provider.of<AuthProvider>(context, listen: false).verifyOtp(widget.mobileNumber).then((value) {
//                                 if(value.isSuccess) {
//                                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//                                   //     builder: (_) => ResetPasswordWidget(mobileNumber: widget.mobileNumber,
//                                   //         otp: authProvider.verificationCode)), (route) => false);
//                                   }else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text(getTranslated('input_valid_otp', context)!),
//                                         backgroundColor: ColorResources.primaryOrangeColor)
//                                   );
//                                 }
//                               });
//                             }else{
//                               if(Provider.of<SplashProvider>(context,listen: false).configModel!.phoneVerification!){
//                                 Provider.of<AuthProvider>(context, listen: false).verifyPhone(widget.mobileNumber,widget.tempToken).then((value) {
//                                   if(value.isSuccess) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text(getTranslated('sign_up_successfully_now_login', context)!),
//                                           backgroundColor: Colors.green,)
//                                     );
//                                     loginUser();
//
//                                     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//                                     //     builder: (_) => const MainAuthScreen()), (route) => false);
//                                   }else {
//                                     showCustomSnackBar(getTranslated(value.message!, context)??value.message , context);
//                                   }
//                                 });
//                               }
//                             }
//
//
//
//
//
//                           },
//                         ),
//                       ):  const Center(child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>( ColorResources.primaryColor)))
//                           : const SizedBox.shrink()
//
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
