class BaseResponse<T> {
  final T? data;
  final String? error;

  BaseResponse({this.data, this.error});

  bool get hasError => error != null;
}
