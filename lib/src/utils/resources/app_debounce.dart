
import 'dart:async';
import 'package:flutter/material.dart';

class AppDebounce {
  final int milliseconds;
  Timer? _timer;

  AppDebounce({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}