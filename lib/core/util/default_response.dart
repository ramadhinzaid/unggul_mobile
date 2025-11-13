class DefaultResponse {
  int? statusCode;
  String? message;

  DefaultResponse({this.statusCode, this.message});

  DefaultResponse.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status_code']?.toString() ?? '');
    message = json['message']?.toString();
  }

  String toEntity() => message ?? '';
}
