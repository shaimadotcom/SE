import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../data/model/language_model.dart';
import '../screens/base_widgets/errorMessageOverlayContainer.dart';
import 'color_resources.dart';
import 'custom_themes.dart';
import 'dimensions.dart';

class AppConstants {
  static const String appName = 'Musafer';
  static const String appVersion = '1.0';
  static const String baseUrl = 'https://java-learn.labs2030.com';

  static const String registrationUri = '/api/users/register';
  static const String loginUri = '/api/users/login';
  static const String tripDetailsUri = '/api/trip/details/';
  static const String tripReviewUri = '/api/trip/reviews/';
  static const String searchUri = '/api/trips/search?name=';
  static const String configUri = '/api/get-data';

  static const String checkPhoneUri = '/api/auth/check-phone';
  static const String resendPhoneOtpUri = '/api/auth/check-phone';
  static const String verifyPhoneUri = '/api/verify';
  static const String resetPasswordUri = '/api/auth/reset-password';
  static const String verifyOtpUri = '/api/auth/verify-otp';

  static const String customerUri = '/api/get-user-data';
  static const String updateUser = '/api/users/update';
  static const String usersSScores = '/api/get-users-data';

  static const String saveProgress = '/api/users/save-progress';
  static const String allCustomersUri = '/api/get-users-data';
  static const String deleteCustomerAccount = '/api/passenger/account-delete';
  static const String updateProfileUri = '/api/passenger/update-profile';


  // sharePreference
  static const String token = 'token';
 // static const String guestToken = 'guest_token';
  static const String user = 'user';
  static const String userPhone = 'user_phone';
  static const String userPassword = 'user_password';
  static const String homeAddress = 'home_address';
  static const String config = 'config';
  static const String guestMode = 'guest_mode';
  static const String currency = 'currency';
  static const String langKey = 'lang';
  static const String intro = 'intro';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String loginDescription = 'login_description';
  // trip status
  static const String started = 'started';
  static const String cancelled = 'cancelled';
  static const String coming = 'coming';
  static const String finished = 'finished';
  static const String arrived = 'arrived';
  static const String failed = 'failed';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String isplaying = 'is_playing';
  static const String theme = 'theme';
  static const String topic = 'musafer';
  static const String userAddress = 'user_address';
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en',shortcut: 'EN'),
    LanguageModel(imageUrl: '', languageName: 'عربي', countryCode: 'SY', languageCode: 'ar',shortcut: 'عربي'),
  ];

  static Future<dynamic> showBottomSheet({
    required Widget child,
    required BuildContext context,
    bool? enableDrag,
  }) async {
    final result = await showModalBottomSheet(
      enableDrag: enableDrag ?? false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.bottomSheetTopRadius),
          topRight: Radius.circular(Dimensions.bottomSheetTopRadius),
        ),
      ),
      context: context,
      builder: (_) => child,
    );

    return result;
  }

  static Future<void> showCustomSnackBar({
    required BuildContext context,
    required String errorMessage,
    required Color backgroundColor,
    Duration delayDuration = errorMessageDisplayDuration,
  }) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => ErrorMessageOverlayContainer(
        backgroundColor: backgroundColor,
        errorMessage: errorMessage,
      ),
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(delayDuration);
    overlayEntry.remove();
  }


}
 var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
);

void showConfirmationDialog(BuildContext context, {Function()? okPress, Function()? cancelPress,String? title,String? content,String? oktext,String? canceltext}) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(title??"",style: beINNormal.copyWith(color: ColorResources.black, fontSize: 14)),
        content: Text(content??"",style: beINNormal.copyWith(color: ColorResources.black, fontSize: 12)),
        actions: [
          TextButton(
            onPressed:okPress,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return ColorResources.primaryOrangeColor.withOpacity(0.09); // Set overlay color to transparent
                },
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * Dimensions.homeButtonsPercentage/2.5,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorResources.primaryOrangeColor, borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Align(
                alignment: Alignment.center,
                child: Text(oktext??"",
                  style: beINNormal.copyWith(color: ColorResources.white, fontSize: 14),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed:cancelPress,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return ColorResources.primaryOrangeColor.withOpacity(0.09); // Set overlay color to transparent
                },
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * Dimensions.homeButtonsPercentage/4,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(shape: BoxShape.rectangle, color: ColorResources.primaryColor, borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Align(
                alignment: Alignment.center,
                child: Text(canceltext??"",
                  style: beINNormal.copyWith(color: ColorResources.white, fontSize: 14),
                ),
              ),
            ),
          ),

        ],
      );
    },
  );
}

const bool isApplicationItemAnimationOn = true;
const int listItemAnimationDelayInMilliseconds = 100;
const int itemFadeAnimationDurationInMilliseconds = 250;
const int itemZoomAnimationDurationInMilliseconds = 200;
const int itemBouncScaleAnimationDurationInMilliseconds = 200;
const Duration errorMessageDisplayDuration = Duration(milliseconds: 3000);
const Duration homeMenuBottomSheetAnimationDuration =
Duration(milliseconds: 300);