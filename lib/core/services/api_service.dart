import 'package:dio/dio.dart';

//Singleton Pattern
class ApiService {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  ApiService._internal();

  static init() {
    // Cấu hình Dio ở đây
    _dio.options.baseUrl = 'http://192.168.1.6:8000/apis';
    // _dio.options.baseUrl = 'https://ctue-learn-english-api.onrender.com/apis';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.connectTimeout =
        const Duration(milliseconds: 10000); // Timeout sau 5 giây
    _dio.options.receiveTimeout =
        const Duration(milliseconds: 30000); // Timeout nhận dữ liệu sau 3 giây

    // dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
    //   // Xử lý response trước khi trả về cho ứng dụng
    //   var responseData = ResponseDataModel(
    //     data: response.data['data'],
    //     statusCode: response.statusCode!,
    //     message: response.data['message'],
    //   );

    //   handler.resolve(responseData as Response);
    // }));
  }
}
