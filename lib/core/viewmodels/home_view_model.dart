import 'package:flutter/material.dart';
import 'package:volv/core/utils/gretting_message.dart';
import 'package:volv/core/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String showGreeting() {
    return greetingMessage();
  }
}
