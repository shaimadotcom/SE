// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'code_picker_widget.dart';
// import 'otp_verification_screen.dart';
//
// class SignInWidget extends StatefulWidget {
//   const SignInWidget({Key? key}) : super(key: key);
//
//   @override
//   SignInWidgetState createState() => SignInWidgetState();
// }
//
// class SignInWidgetState extends State<SignInWidget> {
//   TextEditingController? _passwordController;
//   final TextEditingController _phoneController = TextEditingController();
//   GlobalKey<FormState>? _formKeyLogin;
//   String? _deviceId;
//   final _deviceIdInfoPlugin = DeviceIdInfo("com.musafer.passenger");
//   String? _countryDialCode = "+963";
//   @override
//   void initState() {
//     super.initState();
//     //initPlatformState();
//     _formKeyLogin = GlobalKey<FormState>();
//     _passwordController = TextEditingController();
//     _phoneController.text= (Provider.of<AuthProvider>(context, listen: false).getUserPhone());
//     _passwordController!.text = (Provider.of<AuthProvider>(context, listen: false).getUserPassword());
//   }
//
//   @override
//   void dispose() {
//     _passwordController!.dispose();
//     super.dispose();
//   }
//
//   final FocusNode _passNode = FocusNode();
//   final FocusNode _phoneFocus = FocusNode();
//
//   LoginModel loginBody = LoginModel();
//
//   void loginUser() async {
//     if (_formKeyLogin!.currentState!.validate()) {
//       _formKeyLogin!.currentState!.save();
//
//       String phone = _phoneController.text.trim();
//       String phoneNumber = _countryDialCode!+_phoneController.text.trim();
//       String password = _passwordController!.text.trim();
//
//       if (phone.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//
//       }   else if (!RegExp(r'^9\d{8}$').hasMatch(phone)) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('ENTER_Valid_MOBILE_NUMBER', context)??"MOBILE NUMBER Must Be 9xx xxx xxx"),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       }else if (password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
//           backgroundColor: ColorResources.primaryOrangeColor,
//         ));
//       } else {
//
//         if (Provider.of<AuthProvider>(context, listen: false).isRemember!) {
//          Provider.of<AuthProvider>(context, listen: false).saveUserPhone(phone, password);
//         } else {
//          Provider.of<AuthProvider>(context, listen: false).clearUserPhoneAndPassword();
//         }
//         loginBody.mobile = phoneNumber;
//         loginBody.password = password;
//         await Provider.of<AuthProvider>(context, listen: false).login(loginBody, route);
//       }
//     }
//   }
//   // Future<void> initPlatformState() async {
//   //   String? deviceId;
//   //   try {
//   //     deviceId =
//   //         await _deviceIdInfoPlugin.getDeviceId() ?? 'Unknown platform version';
//   //   } on PlatformException {
//   //     deviceId = 'Failed to get device ID.';
//   //   }
//   //   if (!mounted) return;
//   //   setState(() {
//   //     _deviceId = deviceId;
//   //   });
//   // }
//   route(bool isRoute, String? token, String? temporaryToken, String? errorMessage,bool? verified,int newCode) async {
//     if (isRoute) {
//   //  //   if(token==null || token.isEmpty){
//   //  //    if(Provider.of<SplashProvider>(context,listen: false).configModel!.phoneVerification!){
//     ////       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MobileVerificationScreen(
//     ////           temporaryToken!)), (route) => false);
//     //  //   }
//     //   //}
//     //// else{
//         await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
//         if(context.mounted){}
//         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
//      //}
//     } else if(verified !=null &&!verified){
//       String phone = _countryDialCode!+_phoneController.text.trim();
//       Provider.of<AuthProvider>(context, listen: false).checkPhone(phone,token!).then((value) async {
//         if (value.isSuccess) {
//           Provider.of<AuthProvider>(context, listen: false).updatePhone(phone);
//           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => VerificationScreen(token,phone,testcode: newCode,)), (route) => false);
//
//         }
//       });
//       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => VerificationScreen(
//       //     token??"",phone,testcode: newCode,)), (route) => false);
//     }else
//     {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(errorMessage!, context)??errorMessage ), backgroundColor: ColorResources.primaryOrangeColor));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<AuthProvider>(context, listen: false).isRemember;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSizeLarge),
//       child: Form(
//         key: _formKeyLogin,
//         child: ListView(
//           padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: Dimensions.marginSizeExtraLarge),
//               child: Row(children: [
//                 Expanded(child: CustomTextField(
//                   hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
//                   controller: _phoneController,
//                   focusNode: _phoneFocus,
//                   nextNode: _passNode,
//                   isPhoneNumber: true,
//                   textInputAction: TextInputAction.next,
//                   textInputType: TextInputType.phone,
//                 )),
//                 Directionality(
//                   textDirection: TextDirection.ltr,
//                   child: CodePickerWidget(
//                     // onChanged: (CountryCode countryCode) {
//                     //   _countryDialCode = countryCode.dialCode;
//                     // },
//                     enabled: false,
//                     initialSelection: _countryDialCode,
//                     favorite: [_countryDialCode!],
//                     showDropDownButton: false,
//                     padding: EdgeInsets.zero,
//                     showFlagMain: true,
//                     textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
//
//                   ),
//                 ),
//               ]),
//             ),
//
//
//
//             Container(
//                 margin:
//                 const EdgeInsets.only(bottom: Dimensions.marginSizeDefault),
//                 child: CustomPasswordTextField(
//                   hintTxt: getTranslated('ENTER_YOUR_PASSWORD', context),
//                   textInputAction: TextInputAction.done,
//                   focusNode: _passNode,
//                   controller: _passwordController,
//                 )),
//
//
//
//             Container(
//               margin: const EdgeInsets.only(right: Dimensions.marginSizeSmall),
//               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [Row(children: [
//                   Consumer<AuthProvider>(
//                     builder: (context, authProvider, child) => Checkbox(
//                       checkColor: ColorResources.white,
//                       activeColor: ColorResources.primaryColor,
//                       value: authProvider.isRemember,
//                       onChanged: authProvider.updateRemember,),),
//
//
//                   Text(getTranslated('REMEMBER', context)!, style: titilliumRegular),
//                 ],),
//
//                   InkWell(
//                     //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgetPasswordScreen())),
//                     child: Text(getTranslated('FORGET_PASSWORD', context)!,
//                         style: titilliumRegular.copyWith(
//                         color: ColorResources.getLightSkyBlue(context))),
//                   ),
//                 ],
//               ),
//             ),
//
//
//
//             Container(
//               margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
//               child: Provider.of<AuthProvider>(context).isLoading ?
//               Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>( ColorResources.primaryColor,),),) :
//               CustomButton(onTap: loginUser, buttonText: getTranslated('SIGN_IN', context)),),
//             const SizedBox(width: Dimensions.paddingSizeDefault),
//
//             const SizedBox(width: Dimensions.paddingSizeDefault),
//           ],
//         ),
//       ),
//     );
//
//
//   }
//
// }
