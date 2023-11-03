import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class CoreDio with DioMixin implements Dio {
   static const _timeOutDuration = Duration(seconds: 50);

  CoreDio._([BaseOptions? options]) {
    options = BaseOptions(
      contentType: 'application/json; charset=utf-8',
      connectTimeout: _timeOutDuration,
      sendTimeout: _timeOutDuration,
      receiveTimeout: _timeOutDuration,
    );

    this.options = options;

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(options);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (error, handler) async {
          handler.next(error);
        },
      ),
    );
    httpClientAdapter = IOHttpClientAdapter();
  }

  static final _instance = CoreDio._();

  static CoreDio get instance => _instance;
}
