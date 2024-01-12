import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../UTILS/dialog_helper.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';
import '../main.dart';
import '../utils/network_strings.dart';

class Network {
  static Dio? _dio;
  static CancelToken? _cancelRequestToken;
  static Network? _network;
  static int connectTimeOut = 20000;
  static int receivingTimeOut = 6000;

  Network._createInstance();

  factory Network() {
    if (_network == null) {
      _network = Network._createInstance();

      _dio = _getDio();
      _cancelRequestToken = _getCancelToken();
    }
    return _network!;
  }

  static Dio _getDio() {
    return _dio ??= Dio();
  }

  static CancelToken _getCancelToken() {
    return _cancelRequestToken ??= CancelToken();
  }

  ////////////////// Get Request ///////////////////////

  Future<Response?> getRequest(
      {String baseUrl = NetworkStrings.API_BASE_URL,
      required String endPoint,
      Map<String, dynamic>? queryParameters}) async {
    Response? response;
   // String? token = await // // Utility.getStringValue(NetworkStrings.TOKEN_KEY);

    var token = await Utility.getStringValue(RequestString.TOKEN);
print('token:$token');

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout =  Duration(milliseconds: connectTimeOut);
        response = await _dio!.get(baseUrl + endPoint,
            queryParameters: queryParameters,
            cancelToken: _cancelRequestToken,
            options: Options(
              headers: {
                'Accept': NetworkStrings.ACCEPT,
                'Authorization':token == "" ? "" : "Bearer $token",

              },
              sendTimeout: Duration(milliseconds: receivingTimeOut),
              receiveTimeout: Duration(milliseconds: receivingTimeOut),
            ));
        print(response);
      } on DioException catch (e) {
        log("Error :${e.response.toString()}");
        if (e.response?.statusCode == 403) {
          // // Utility.clearAll();
          //getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(navigatorKey.currentContext!,
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    print(
        "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nrequest======$queryParameters\n\nresponse========== $response");

    return response;
  }

  ///////////////////// Post Request /////////////////////////

  Future<Response?> postRequest({
    required String endPoint,
    Map<String, dynamic>? formData,
    bool isLoader = true,
  }) async {
    if (isLoader) {
     DialogHelper.showLoading(navigatorKey.currentContext!);
    }
    Response? response;
    var token = await Utility.getStringValue(RequestString.TOKEN);



    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(seconds: connectTimeOut);

        print("Request: ${NetworkStrings.API_BASE_URL + endPoint} +===+$formData+====+$token");

        response = await _dio!.post(NetworkStrings.API_BASE_URL + endPoint,
            data: formData!,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
                  'Authorization':token == "" ? "" : "Bearer $token",
                },
                sendTimeout:  Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut)));
        DialogHelper.hideLoading(navigatorKey.currentContext!);
      } on DioException catch (e) {
        DialogHelper.hideLoading( navigatorKey.currentContext!);
        print("$endPoint Dio: ${e.message}" );
        if (e.response?.statusCode == 403) {
          // // Utility.clearAll();
          //getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(navigatorKey.currentContext!,
            title: "Server response", description: e.response?.data['message'].toString());
        print("my response mi : ${e.toString()}");
      }
    } else {
      _noInternetConnection();
    }
    print(
        "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nrequest======$formData\n\nresponse========== $response");

    return response;

  }

  //////////////Delete Updated//////////


  Future<Response?> deleteRequest({
    required String endPoint,
    bool isLoader = true,
  }) async {
    if (isLoader) {
      DialogHelper.showLoading(navigatorKey.currentContext!);
    }

    var token =  await Utility.getStringValue(RequestString.TOKEN);
    print("auth Token: $token");

    Response? response;

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.delete(
          NetworkStrings.API_BASE_URL + endPoint,
          cancelToken: _cancelRequestToken,
          options: Options(
            headers: {
              'Accept': NetworkStrings.ACCEPT,
              'Authorization': 'Bearer ${await Utility.getStringValue(RequestString.TOKEN)}',
            },
            sendTimeout: Duration(milliseconds: receivingTimeOut),
            receiveTimeout: Duration(milliseconds: receivingTimeOut),
          ),
        );
        DialogHelper.hideLoading(navigatorKey.currentContext!);
      } on DioException catch (e) {
        DialogHelper.hideLoading(navigatorKey.currentContext!);
        print("$endPoint Dio: ${e.message}");
        if (e.response?.statusCode == 403) {
          // Perform actions for 403 Forbidden, e.g., navigate to sign-in screen
          // getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
          navigatorKey.currentContext!,
          title: "Server response",
          description: e.response?.data['message'],
        );
      }
    } else {
      _noInternetConnection();
    }

    print(
      "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nresponse========== $response",
    );

    return response;
  }


  ////////////////// Put Request /////////////////////////
  Future<Response?> putRequest(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    Response? response;
   // String? token = await // // Utility.getStringValue(NetworkStrings.TOKEN_KEY);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.put(NetworkStrings.API_BASE_URL + endPoint,
            //queryParameters: queryParameters,
            data: queryParameters,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
               //   'Authorization': token == null ? "" : "Bearer $token",
                },
                sendTimeout: Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut)));
        //print(response);
      } on DioException catch (e) {
        print("$endPoint Dio: ${e.message}" );
        if (e.response?.statusCode == 403) {
          // // Utility.clearAll();
        //  getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(navigatorKey.currentContext!,
            title: "Error", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    if ((response?.statusCode ?? 0) <= 400) {
      DialogHelper.showErrorDialog(navigatorKey.currentContext!,
          title: "Server response", description: response?.data["message"]);
    }
    return response;
  }

  Future<Response?> uploadFile(File file, String type) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
      "type": type
    });
    DialogHelper.showLoading(navigatorKey.currentContext!);
    Response? response;
   // String? token = await // // Utility.getStringValue(NetworkStrings.TOKEN_KEY);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.post(
           'http://3.145.80.252/api/upload-image',
            data: formData,
            cancelToken: _cancelRequestToken,
            options: Options(
              headers: {
                'Accept': NetworkStrings.ACCEPT,
               // 'Authorization': token == null ? "" : "Bearer $token",
              },
              sendTimeout: Duration(milliseconds: receivingTimeOut),
              receiveTimeout: Duration(milliseconds: receivingTimeOut),
            ));
        DialogHelper.hideLoading(navigatorKey.currentContext!);
      } on DioException catch (e) {
        DialogHelper.hideLoading(navigatorKey.currentContext!);
        if (e.response?.statusCode == 403) {
          // // Utility.clearAll();
      //    getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(navigatorKey.currentContext!,
            title: "Server response", description: e.response?.statusMessage);
      }
    } else {
      _noInternetConnection();
    }
   // print('=====================${response?.data["data"]["url"]}');
    return response;
  }

  Future<Response?> createProfile(Map<String,dynamic>? payload,{File? file,String? endPoint}) async {
/*
      String fileName = file!
          .path
          .split('/')
          .last;
      FormData formData = FormData.fromMap({
        "userCV": await MultipartFile.fromFile(file!.path, filename: fileName),
        payload!
      });*/

      DialogHelper.showLoading(navigatorKey.currentContext!);
      Response? response;
     // String? token = await // // Utility.getStringValue(NetworkStrings.TOKEN_KEY);

      if (await InternetConnectionChecker().hasConnection) {
        try {
          _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
          response = await _dio!.post(
              NetworkStrings.API_BASE_URL + endPoint!,
              data: FormData.fromMap(payload!),
              cancelToken: _cancelRequestToken,
              options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
                 // 'Authorization': token == null ? "" : "Bearer $token",
                },
                sendTimeout: Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut),
              ));
          DialogHelper.hideLoading(navigatorKey.currentContext!);
          print("server response====${response}");
        } on DioException catch (e) {
          DialogHelper.hideLoading(navigatorKey.currentContext!);
          if (e.response?.statusCode == 403) {
            // // Utility.clearAll();
            //getx.Get.offAll(const SignInScreen());
          }
          DialogHelper.showErrorDialog(navigatorKey.currentContext!,
              title: "Server response",
              description: e.response?.data['message']);
        }
      } else {
        _noInternetConnection();
      }
      print(
          "API=======${NetworkStrings.API_BASE_URL + NetworkStrings.USER_SIGN_UP}\n\nrequest======$payload\n\nresponse========== $response");

    return response;
  }
  ////////////////// No Internet Connection /////////////////////
  void _noInternetConnection() {
    DialogHelper.showErrorDialog( navigatorKey.currentContext!,title : "Internet Connection!",description : NetworkStrings.NO_INTERNET_CONNECTION);
  }
}
