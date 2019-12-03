import 'package:dio/dio.dart';
import 'package:vc_flutter_shop_plus/config/service_config.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端服务接口出现异常');
    }
  } catch (e) {
    return print('error:=>${e.toString()}');
  }
}


