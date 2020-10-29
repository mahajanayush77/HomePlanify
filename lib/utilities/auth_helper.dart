import 'api-response.dart';
import 'api_endpoints.dart';
import 'http_exception.dart';
import 'api_helper.dart';

Future<bool> autoLogin() async {
  final status = await ApiHelper().isLoggedIn();
  //print(status);
  print('uID: ${ApiHelper().getUID()},');
  return status;
}

Future<void> logIn(String email, String password) async {
  print('email: $email password: $password');
  Map<String, String> data = {
    'email': email,
    'password': password,
  };
  try {
    await ApiHelper().logIn(data);
  } on HttpException catch (error) {
    throw HttpException(message: error.toString());
  } catch (error) {
    throw error;
  }
}

Future<void> logOut() async {
  //Flush other variables if required
  await ApiHelper().logOut();
}

Future<void> changePassword(String oldPassword, String newPassword) async {
  print('old: $oldPassword, new: $newPassword');
  Map<String, String> data = {
    'new_password1': newPassword,
    'new_password2': newPassword,
  };
  try {
    final ApiResponse response =
        await ApiHelper().postRequest(eChangePassword, data);

    if (response.error) {
      throw HttpException(message: response.errorMessage);
    }
  } on HttpException catch (error) {
    throw HttpException(message: error.toString());
  } catch (e) {
    print(e.toString());
    throw e;
  }
}
