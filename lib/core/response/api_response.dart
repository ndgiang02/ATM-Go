import 'package:atmgo/core/response/status.dart';

class ApiResponse<T> {
  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  Status? status;
  T? data;
  String? message;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
