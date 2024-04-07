import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
part 'index.g.dart';

class SignInStore = _SignInStoreBase with _$SignInStore;

abstract class _SignInStoreBase with Store {
  _SignInStoreBase() {
    init();
  }

  Map<String, dynamic> rememberData = {};

  @observable
  bool passwordVisible = false;

  @action
  changePasswordVisibility() {
    passwordVisible = !passwordVisible;
  }

  @action
  void init() {
    final box = Hive.box('remember');
    String? boxValue = box.get('data');

    if (boxValue != null) {
      rememberData = jsonDecode(boxValue);
    }
  }
}
