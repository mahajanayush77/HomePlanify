import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:housing/constant.dart';
import 'package:housing/utilities/api-response.dart';
import 'package:housing/utilities/api_endpoints.dart';
import 'package:housing/utilities/api_helper.dart';
import 'package:housing/widgets/bottom_bar.dart';
import 'package:housing/utilities/http_exception.dart';

class MyProfile extends StatefulWidget {
  static const routeName = '/ContactUs';

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameCtl = TextEditingController();
  final TextEditingController lastnameCtl = TextEditingController();

  Future<ApiResponse> _response;

  @override
  void initState() {

    _response = ApiHelper().getRequest(
      endpoint: eMyProperties,
    );
    firstnameCtl.text
    

    super.initState();
  }

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data = {
      'first_name': nameCtl.text,
      'last_name': emailCtl.text,
      'mobile': mobileCtl.text,
      'message': messageCtl.text,
    };

    try {
      final ApiResponse response = await ApiHelper().postRequest(
        '$eContact',
        data,
      );
      if (!response.error) {
        Flushbar(
          message: 'Message Sent successfully!',
          duration: Duration(seconds: 3),
        )
          ..show(context);
        firstnameCtl.clear();
        lastnameCtl.clear();
      }
      else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to send',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {
      Flushbar(
        message: 'Unable to send',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = DeviceSize(context: context);

    final MaterialLocalizations localizations =
    MaterialLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: Text('Contact Us'),
      ),
      bottomNavigationBar: bottom_bar(3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    child: Center(
                      child: Text(
                        "HomePlanify",
                        style: TextStyle(
                          color: kPrimaryBackgroundColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
                Container(
                    child: Center(
                      child: Text(
                        "We're here to help you.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: nameCtl,
                  keyboardType: TextInputType.text,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Name can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: emailCtl,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Email can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: mobileCtl,
                  keyboardType: TextInputType.number,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Please provide a Mobile Number';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: messageCtl,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(height: 1.0),
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Message can\'t be empty';
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),

                (_isLoading)
                    ? SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                )
                    : MaterialButton(
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: kPrimaryBackgroundColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    _saveForm();
                  },
                  child: Text('Send Message'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
