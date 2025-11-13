class BaseResponse<T> {
  final T? data;
  final String? error;

  const BaseResponse({this.data, this.error});

  bool get hasError => error != null && error!.isNotEmpty;
}
