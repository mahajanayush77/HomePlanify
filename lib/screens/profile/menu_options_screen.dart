import 'package:flutter/material.dart';
import '../../utilities/api_helper.dart';
import './option_model.dart';
import '../../constant.dart';
import '../../widgets/bottom_bar.dart';

// Drawer menu in profile screen
class MenuOptionsScreen extends StatefulWidget {
  @override
  _MenuOptionsScreenState createState() => _MenuOptionsScreenState();
}

class _MenuOptionsScreenState extends State<MenuOptionsScreen> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: Text('Profile'),
      ),
      body: ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == options.length + 1) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: _selectedOption == index - 1
                    ? Border.all(color: Colors.black26)
                    : null,
              ),
              child: ListTile(

                leading: Icon(Icons.logout, size: 40.0),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: _selectedOption == index - 1
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),

                selected: _selectedOption == index - 1,
                onTap: () async {
                  await ApiHelper().logOut().then((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  });
                }
              ),
            );
            return SizedBox(height: 50.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: _selectedOption == index - 1
                  ? Border.all(color: Colors.black26)
                  : null,
            ),
            child: ListTile(

              leading: options[index - 1].icon,
              title: Text(
                options[index - 1].title,
                style: TextStyle(
                  color: _selectedOption == index - 1
                      ? Colors.black
                      : Colors.grey[600],
                ),
              ),
              selected: _selectedOption == index - 1,
              onTap: () {
                setState(() {
                  _selectedOption = index - 1;
                });
                Navigator.pushNamed(context, options[index-1].gestureLink);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: bottom_bar(3),
    );
  }
}
