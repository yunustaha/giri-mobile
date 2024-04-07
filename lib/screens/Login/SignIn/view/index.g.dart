// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInStore on _SignInStoreBase, Store {
  late final _$passwordVisibleAtom =
      Atom(name: '_SignInStoreBase.passwordVisible', context: context);

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  late final _$_SignInStoreBaseActionController =
      ActionController(name: '_SignInStoreBase', context: context);

  @override
  dynamic changePasswordVisibility() {
    final _$actionInfo = _$_SignInStoreBaseActionController.startAction(
        name: '_SignInStoreBase.changePasswordVisibility');
    try {
      return super.changePasswordVisibility();
    } finally {
      _$_SignInStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init() {
    final _$actionInfo = _$_SignInStoreBaseActionController.startAction(
        name: '_SignInStoreBase.init');
    try {
      return super.init();
    } finally {
      _$_SignInStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
passwordVisible: ${passwordVisible}
    ''';
  }
}
