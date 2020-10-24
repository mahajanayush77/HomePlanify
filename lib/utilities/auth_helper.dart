import 'api-response.dart';
import 'api_endpoints.dart';
import 'http_exception.dart';
import 'api_helper.dart';
import '../constant.dart';
Future<bool> autoLogin() async {
  final status = await ApiHelper().isLoggedIn();
  //print(status);
  print(
      'uID: ${ApiHelper().getUID()}, lID: ${ApiHelper().getLibraryID()}, bID: ${ApiHelper().getCurrentBranchID()}');
  return status;
}

Future<void> logIn(String username, String password) async {
  print('username: $username password: $password');
  Map<String, String> data = {

    'username': username,
    'password': password,
  };
  try {
    await ApiHelper().logIn(data);
    await fetchAndSetLibraryDetails();
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

Future<void> fetchAndSetLibraryDetails() async {
  print(' fetch called');

  try {
    final Map<String, String> query = {
      'user': ApiHelper().getUID(),
    };
    final ApiResponse response = await ApiHelper().getRequest(endpoint: eEmployeeProfile, query: query);
    if (!response.error) {


      final  libraryID = response.data.toList()[0]['library'];

      final  branchID = response.data.toList()[0]['branches'].toList()[0];

      await ApiHelper().setLibraryID(libraryID.toString());
      if (branchID != null)
        await ApiHelper().setCurrentBranchID(branchID.toString());
    }else{
      throw HttpException(message: response.errorMessage);
    }
  } on HttpException catch (error) {
    throw HttpException(message: error.toString());
  } catch (error) {
    throw error;
  }
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


