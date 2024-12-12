class BaseResponse {
  int? status;
  bool? success;
  var errorGeneric;
  dynamic data;
  var error;

  BaseResponse({this.status, this.success, this.data, this.errorGeneric}) {
    if (errorGeneric is List) {
      error = '';
      for (String a in errorGeneric) {
        error += a;
        error += '\n';
      }
    }else{
      error = errorGeneric;
    }

  }
}
