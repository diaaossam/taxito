class ApiSuccessResponse<T> {
  final String? message;
  final bool? success;
  final T? data;
  final Map<String, dynamic>? response;

  ApiSuccessResponse({this.message, this.success, this.data, this.response});
}
