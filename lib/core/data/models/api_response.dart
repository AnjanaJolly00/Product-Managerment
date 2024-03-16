class ApiResponse<T> {
  /// true = request is success
  bool isSuccessful;
  int? code;

  /// response data for the request
  T? rawResponse;

  /// Error message which can be displayed to user
  String? errorMsg;
  String? requestUrl;

  ApiResponse({
    this.isSuccessful = false,
    this.code = 400,
    this.rawResponse,
    this.errorMsg = "",
    this.requestUrl,
  });

  ApiResponse<T> copyWith({
    bool? isSuccessful,
    int? code,
    T? rawResponse,
    String? errorMsg,
    String? requestUrl,
  }) {
    return ApiResponse<T>(
      isSuccessful: isSuccessful ?? this.isSuccessful,
      code: code ?? this.code,
      rawResponse: rawResponse ?? this.rawResponse,
      errorMsg: errorMsg ?? this.errorMsg,
      requestUrl: requestUrl ?? this.requestUrl,
    );
  }
}
