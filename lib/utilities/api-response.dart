//  class to store an API Response
class ApiResponse {
  final data;
  final bool error;
  final String errorMessage;

  ApiResponse({this.data, this.error: false, this.errorMessage: ''});
}
