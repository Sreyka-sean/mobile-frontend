import 'package:flutter/material.dart';
import '../pages/BecomeSellerPage.dart';
import '../pages/CartPage.dart';
import '../pages/CategoryProductsPage.dart';
import '../pages/EarningDashboardPage.dart';
import '../pages/FarmerNotificationsPage.dart';
import '../pages/FarmerOrderConfirmationPage.dart';
import '../pages/Homepage.dart';
import '../pages/ItemInformationPage.dart';
import '../pages/ItemPage.dart';
import '../pages/LoginPage.dart';
import '../pages/ForgetPasswordPage.dart';
import '../pages/LoginSignupPage.dart';
import '../pages/GetCodePage.dart';
import '../pages/MorePage.dart';
import '../pages/MyOrdersPage.dart';
import '../pages/MyProfilePage.dart';
import '../pages/SignUpPage.dart';
import '../pages/SubmitSuccessfulPage.dart';
import '../pages/WishlistPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "/": (context) => HomePage(),
        "CartPage": (context) => CartPage(),
        "itemPage": (context) => ItemPage(),
        '/LoginPage': (context) => LoginPage(),
        '/ForgetPasswordPage': (context) => ForgetPasswordPage(),
        '/GetCodePage': (context) => GetCodePage(),
        '/LoginSignupPage': (context) => LoginSignupPage(),
        '/SignUpPage': (context) => SignUpPage(),
        '/more-page': (context) => MorePage(),
        '/my-profile-page': (context) => MyProfilePage(),
        '/wishlist-page': (context) => WishlistPage(),
        '/become-seller-page': (context) => BecomeSellerPage(),
        '/my-orders-page': (context) => MyOrdersPage(),
        '/category-products-page': (context) => CategoryProductsPage(
          categoryIndex: ModalRoute.of(context)!.settings.arguments as int,
        ),
        '/earning-dashboard-page': (context) => const EarningDashboardPage(), // ✅ Must be added
        '/item-information-page': (context) => const ItemInformationPage(), // New route
        '/submit-successful-page': (context) => const SubmitSuccessfulPage(), // New route
        '/farmer-notifications-page': (context) => const FarmerNotificationsPage(), // New route
        '/farmer-order-confirmation-page': (context) => FarmerOrderConfirmationPage(
          orderMessage: ModalRoute.of(context)?.settings.arguments as String?,
        ),
      },
    );
  }
}