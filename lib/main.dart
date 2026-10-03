import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/rider_home_screen.dart';
import 'screens/earnings/earnings_screen.dart';
import 'screens/history/delivery_history_screen.dart';
import 'screens/profile/rider_profile_screen.dart';
import 'screens/delivery/incoming_request_screen.dart';
import 'screens/delivery/active_delivery_screen.dart';
import 'screens/delivery/delivery_review_screen.dart';

void main() {
  runApp(const MovaRiderApp());
}

class MovaRiderApp extends StatelessWidget {
  const MovaRiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOVA Rider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0F172A),
          secondary: Color(0xFFD4AF37),
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0F172A)),
          titleTextStyle: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFFFF),
          secondary: Color(0xFFD4AF37),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const RiderSplashScreen(),
        '/login': (_) => const RiderLoginScreen(),
        '/register': (_) => const RiderRegisterScreen(),
        '/home': (_) => const RiderHomeScreen(),
        '/earnings': (_) => const EarningsScreen(),
        '/history': (_) => const DeliveryHistoryScreen(),
        '/profile': (_) => const RiderProfileScreen(),
        '/incoming-request': (_) => const IncomingRequestScreen(),
        '/active-delivery': (_) => const ActiveDeliveryScreen(),
        '/review': (_) => const DeliveryReviewScreen(),
      },
    );
  }
}
