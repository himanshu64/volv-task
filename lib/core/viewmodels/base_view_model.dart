import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  final String? _title;
  bool _busy;
  bool _isDisposed = false;

  BaseViewModel({
    bool busy = false,
    String? title,
  })  : _busy = busy,
        _title = title {
    print(title ?? runtimeType.toString());
  }

  bool get busy => _busy;
  bool get isDisposed => _isDisposed;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    } else {
      print('notifyListeners: Notify listeners called after '
          '${_title ?? runtimeType.toString()} has been disposed');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
