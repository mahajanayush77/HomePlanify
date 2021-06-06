import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constant.dart';
import '../../utilities/api-response.dart';
import '../../utilities/api_endpoints.dart';
import '../../utilities/api_helper.dart';
import '../../widgets/bottom_bar.dart';
import '../../utilities/http_exception.dart';

// change password form

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isLoading = false;
  bool _isOldPasswordHidden = true;
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  // form key
  final _formKey = GlobalKey<FormState>();
  // text box controllers in form
  final TextEditingController oldPasswordCtl = TextEditingController();
  final TextEditingController newPasswordCtl = TextEditingController();
  final TextEditingController confirmPasswordCtl = TextEditingController();

  // save form and initiate POST request
  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = {
      'new_password1': newPasswordCtl.text,
      'new_password2': confirmPasswordCtl.text,
      'old_password': oldPasswordCtl.text,
    };
    print(data);
    try {
      final ApiResponse response = await ApiHelper().postRequest(
        '$eChangePassword',
        data,
      );
      if (!response.error) {
        Flushbar(
          message: 'Password Updated Successfully!',
          duration: Duration(seconds: 3),
        )..show(context);
        newPasswordCtl.clear();
        oldPasswordCtl.clear();
        confirmPasswordCtl.clear();
      } else {
        Flushbar(
          message: response.errorMessage ?? 'Unable to Update',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } on HttpException catch (error) {
      throw HttpException(message: error.toString());
    } catch (error) {
      Flushbar(
        message: 'Unable to Update',
        duration: Duration(seconds: 3),
      )..show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBackgroundColor,
        title: Text('Account'),
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
                )),
                Container(
                    child: Center(
                  child: Text(
                    "Your data is safe with us!",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: _isOldPasswordHidden,
                  controller: oldPasswordCtl,
                  keyboardType: TextInputType.text,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: "Old Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isOldPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isOldPasswordHidden = !_isOldPasswordHidden;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  obscureText: _isNewPasswordHidden,
                  controller: newPasswordCtl,
                  keyboardType: TextInputType.text,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: "New Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isNewPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordHidden = !_isNewPasswordHidden;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Password should contain atleast 6 characters.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  obscureText: _isConfirmPasswordHidden,
                  controller: confirmPasswordCtl,
                  keyboardType: TextInputType.text,
                  style: TextStyle(height: 1.0),
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isConfirmPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                  validator: (value) {
                    if (value != newPasswordCtl.text) {
                      return 'Password doesn\'t match.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                SizedBox(
                  height: 10.0,
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
                        child: Text('Update'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
