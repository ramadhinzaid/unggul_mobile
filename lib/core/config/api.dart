import 'package:dio/dio.dart';

enum TimeoutDuration {
  short(20),
  long(60);

  final int value;
  const TimeoutDuration(this.value);
}

class API {
  API(String baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  final Dio _dio;

  //
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    final result = await _dio
        .get(
          path,
          queryParameters: params,
          options: Options(headers: _header()),
        )
        .timeout(Duration(seconds: TimeoutDuration.short.value));
    return result;
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? headers,
  }) async {
    Duration timeout;
    Map<String, String> header;

    //
    header = _header();
    timeout = Duration(seconds: TimeoutDuration.short.value);

    if (body is MultiPartBody) {
      Map<String, dynamic> mapFiles = {};
      header = _headerFile();
      timeout = Duration(seconds: TimeoutDuration.long.value);
      body.files?.forEach((k, v) async {
        if (_validAttachment(v)) {
          mapFiles[k] = await MultipartFile.fromFile(v);
        }
      });
      body = FormData.fromMap({...(body.fields ?? {}), ...mapFiles});
    }

    if ((headers ?? {}).isNotEmpty) header.addAll(headers!);
    final result = await _dio
        .post(
          path,
          data: body,
          queryParameters: params,
          options: Options(headers: header),
        )
        .timeout(timeout);
    return result;
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? headers,
  }) async {
    Duration timeout;
    Map<String, String> header;

    //
    header = _header();
    timeout = Duration(seconds: TimeoutDuration.short.value);

    if (body is MultiPartBody) {
      Map<String, dynamic> mapFiles = {};
      header = _headerFile();
      timeout = Duration(seconds: TimeoutDuration.long.value);
      body.files?.forEach((k, v) async {
        if (_validAttachment(v)) {
          mapFiles[k] = await MultipartFile.fromFile(v);
        }
      });
      body = FormData.fromMap({...(body.fields ?? {}), ...mapFiles});
    }

    if ((headers ?? {}).isNotEmpty) header.addAll(headers!);
    final result = await _dio
        .put(
          path,
          data: body,
          queryParameters: params,
          options: Options(headers: header),
        )
        .timeout(timeout);
    return result;
  }

  Future<Response> patch(
    String path, {
    Map<String, dynamic>? params,
    Object? body,
    Map<String, String>? headers,
  }) async {
    Duration timeout;
    Map<String, String> header;

    //
    header = _header();
    timeout = Duration(seconds: TimeoutDuration.short.value);

    if (body is MultiPartBody) {
      List<MultipartFile> mapFiles = [];
      header = _headerFile();
      timeout = Duration(seconds: TimeoutDuration.long.value);

      for (int i = 0; i < (body.files?.keys ?? []).length; i++) {
        final key = (body.files?.keys ?? []).toList()[i];
        mapFiles.add(await MultipartFile.fromFile(body.files?[key] ?? ''));
      }

      body = FormData.fromMap({...(body.fields ?? {}), 'photo': mapFiles});
    }

    if ((headers ?? {}).isNotEmpty) header.addAll(headers!);
    final result = await _dio
        .patch(
          path,
          data: body,
          queryParameters: params,
          options: Options(headers: header),
        )
        .timeout(timeout);
    return result;
  }

  Future<Response> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? params,
  }) async {
    final result = await _dio
        .delete(
          path,
          data: body,
          queryParameters: params,
          options: Options(headers: _header()),
        )
        .timeout(Duration(seconds: TimeoutDuration.short.value));
    return result;
  }

  // String get _token => LocalStorage.getString(LocalStorageKey.token);

  Map<String, String> _header() {
    Map<String, String> header = {};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';
    // if (_token.isNotEmpty) {
    //   header["Authorization"] = "Bearer $_token";
    // }
    return header;
  }

  Map<String, String> _headerFile() {
    Map<String, String> header = {};
    header['Content-Type'] = 'multipart/form-data';
    // if (_token.isNotEmpty) {
    //   header["Authorization"] = "Bearer $_token";
    // }
    return header;
  }

  bool _validAttachment(String? attachment) {
    String newPath = attachment ?? '';
    return newPath.isNotEmpty &&
        !newPath.startsWith('http') &&
        !newPath.startsWith('https');
  }
}

class MultiPartBody {
  final Map<String, String>? fields;
  final Map<String, String>? files;
  final bool isUrlEncoded;

  const MultiPartBody({this.fields, this.files, this.isUrlEncoded = false});
}
