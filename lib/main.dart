// necessary packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constant.dart'; // constants

// providers
import './provider/filter.dart';
import './provider/my_properties.dart' as my_prop;
import './provider/bookmarks.dart' as bookmarks;
import './provider/properties.dart';

// routes (screens)
import './screens/add_property.dart';
import './screens/contact_us/contact.dart';
import './screens/home/featured_projects.dart';
import './screens/home/invest_properties.dart';
import './screens/profile/bookmarks.dart';
import './screens/profile/change_password.dart';
import './screens/profile/my_profile.dart';
import './screens/profile/my_properties.dart';
import './screens/home/home_page.dart';
import './screens/news_page.dart';
import './screens/onboarding/Login/login_screen.dart';
import './screens/onboarding/Signup/signup_screen.dart';
import './screens/onboarding/Welcome/welcome_screen.dart';
import './screens/profile/menu_options_screen.dart';
import './screens/home/list_view.dart';

// main function of the material app
void main() {
  runApp(MyApp());
}

// main widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // merges nested providers to a single widget tree
      providers: [
        // ctx stands for Build Context
        ChangeNotifierProvider(create: (ctx) => my_prop.MyProperties()),
        ChangeNotifierProvider(create: (ctx) => my_prop.MyProperties()),
        ChangeNotifierProvider(create: (ctx) => bookmarks.Bookmarks()),
        ChangeNotifierProvider(create: (ctx) => Properties()),
        ChangeNotifierProvider(create: (ctx) => Filter()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // specifies the Theme of the whole application
          primaryColor: kPrimaryBackgroundColor,
          accentColor: kAccentBackgroundColor,
        ),
        initialRoute: '/', // initial route (home screen)
        routes: {
          // list of routes
          '/': (context) => HomePage(),
          '/home': (context) => HomePage(),
          '/welcome': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/properties': (context) => Search(),
          '/invest_properties': (context) => InvestProperties(),
          '/featured_projects': (context) => FeaturedProjects(),
          '/news': (context) => news_page(),
          '/addProperty': (context) => AddProperty(),
          '/profile': (context) => MenuOptionsScreen(),
          '/account_profile': (context) => MyProfile(),
          '/bookmarks': (context) => Bookmarks(),
          '/my_properties': (context) => MyProperties(),
          '/contactUs': (context) => ContactUs(),
          '/faq': (context) => MyProperties(),
          '/change_password': (context) => ChangePassword(),
          '/logout': (context) => MyProperties(),
        },
      ),
    );
  }
}
