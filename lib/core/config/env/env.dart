import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_API_PROD')
  static const String baseProd = _Env.baseProd;
  @EnviedField(varName: 'BASE_API_DEV')
  static const String baseDev = _Env.baseDev;
}

// String envMode = "production";
String envMode = 'development';

String baseURL = envMode == 'production' ? Env.baseProd : Env.baseDev;