import 'package:flutter/foundation.dart';

abstract class BaseViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @protected
  void setLoading([bool value = true]) =>
    _isLoading = value;
  
}