import 'package:flutter/material.dart';
import 'package:nurbox/presentation/screen/partner/partner_accepted/partner_accepted_screen.dart';
import 'package:nurbox/presentation/screen/partner/partner_offer/partner_offer_screen.dart';
import 'package:nurbox/presentation/screen/partner/partner_request/partner_request_screen.dart';
import 'package:nurbox/presentation/screen/payment/payment_method_screen.dart';
import 'package:nurbox/presentation/screen/profile/login/login_screen.dart';
import 'package:nurbox/presentation/screen/profile/profile/profile_screen.dart';
import 'package:nurbox/presentation/screen/profile/rental_history/rental_history_screen.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/sms_code_screen.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/sms_code_status.dart';
import 'package:nurbox/presentation/screen/return_power_bank/rental_details/rental_details_screen.dart';
import 'package:nurbox/presentation/screen/return_power_bank/return_checking/return_checking_screen.dart';
import 'package:nurbox/presentation/screen/return_power_bank/return_failed/return_failed_screen.dart';
import 'package:nurbox/presentation/screen/return_power_bank/return_stations/return_stations_screen.dart';
import 'package:nurbox/presentation/screen/return_power_bank/return_success/return_success_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/map_panel/help_screen/how_to_charge_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/map_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/pickup_power_bank/pickup_power_bank_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/qr_scan/qr_scan_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/splash_screen/splash_screen.dart';
import 'package:nurbox/presentation/screen/take_power_bank/station_code/station_code_screen.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => SplashScreen(),
  '/map': (context) => MapScreen(),
  '/qr_code': (context) => QrScanScreen(),
  '/help': (context) => HowToChargeScreen(),
  '/station_code': (context) => StationCodeScreen(),
  '/payment_method': (context) => PaymentMethodScreen(),
  '/pickup_power_bank': (context) => PickupPowerBankScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => ProfileScreen(isLoggedIn: false),
  '/sms_code': (context) => SmsCodeScreen(status: SmsCodeStatus.initial),
  '/rental_history': (context) => RentalHistoryScreen(),

  // Вернуть пауэрбанк
  '/rental_details': (context) => RentalDetailsScreen(),
  '/return_stations': (context) => ReturnStationsScreen(),
  '/return_checking': (context) => ReturnCheckingScreen(),
  '/return_success': (context) => ReturnSuccessScreen(),
  '/return_failed': (context) => ReturnFailedScreen(),

  // Партнёрам
  '/partner_offer': (context) => PartnerOfferScreen(),
  '/partner_request': (context) => PartnerRequestScreen(),
  '/partner_accepted': (context) => PartnerAcceptedScreen(),
};
