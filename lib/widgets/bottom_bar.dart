import 'package:flutter/material.dart';
import 'package:housing/constant.dart';
import 'package:housing/screens/onboarding/Login/login_screen.dart';
import 'package:housing/screens/profile_page.dart';
import 'package:housing/screens/splash_screen.dart';
import '../utilities/auth_helper.dart' as AuthHelper;

class bottom_bar extends StatefulWidget {
  final current_index;
  bottom_bar(this.current_index);
  @override
  _bottom_barState createState() => _bottom_barState();
}

class _bottom_barState extends State<bottom_bar> {
  List<bool> selected = [false, false, false, false];

  void updateUI(index) {
    if (index == 0) {
      setState(() {
        selected[1] = selected[2] = selected[3] = false;
        selected[0] = true;
      });
    }
    if (index == 1) {
      setState(() {
        selected[0] = selected[2] = selected[3] = false;
        selected[1] = true;
      });
    }
    if (index == 2) {
      setState(() {
        selected[1] = selected[0] = selected[3] = false;
        selected[2] = true;
      });
    }
    if (index == 3) {
      setState(() {
        selected[2] = selected[1] = selected[0] = false;
        selected[3] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    updateUI(widget.current_index);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[100],
      ),
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () {
              updateUI(0);
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 30.0,
                  color: selected[0] ? kPrimaryBackgroundColor : null,
                ),
                Text('Search'),
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () {
              updateUI(1);
              Navigator.pushReplacementNamed(context, '/add_property');
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.add_circle_outline,
                  size: 30.0,
                  color: selected[1] ? kPrimaryBackgroundColor : null,
                ),
                Text('Add'),
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () {
              updateUI(2);
              Navigator.pushReplacementNamed(context, '/news');
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: 30.0,
                  color: selected[2] ? kPrimaryBackgroundColor : null,
                ),
                Text('News'),
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () async {
              updateUI(3);
              var result = await AuthHelper.autoLogin();
              if (result)
                Navigator.pushReplacementNamed(context, '/profile');
              else
                Navigator.pushNamed(context, '/login');
//              FutureBuilder(
//                future: AuthHelper.autoLogin(),
//                builder: (context, authResultSnapshot) {
//                  if (authResultSnapshot.connectionState ==
//                      ConnectionState.waiting) return SplashScreen();
//                  if (authResultSnapshot.hasData) {
//                    if (authResultSnapshot.data) {
//                      print('prefs exist');
//                      return profile_page();
//                    }
//                  }
//                  return LoginScreen();
//                },
//              );
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  size: 30.0,
                  color: selected[3] ? kPrimaryBackgroundColor : null,
                ),
                Text('Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
