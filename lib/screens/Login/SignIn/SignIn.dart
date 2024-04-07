import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:giri/screens/Login/SignIn/view/index.dart';
import 'package:giri/services/Auth/index.dart';
import 'package:giri/utils/index.dart';
import 'package:giri/widgets/Logo.dart';

class SignIn extends StatelessWidget with GiriMixin {
  SignIn({super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  final size = PlatformDispatcher.instance.views.first.physicalSize / PlatformDispatcher.instance.views.first.devicePixelRatio;
  SignInStore signInStore = SignInStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Logo(),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          FormBuilderTextField(
                            name: 'username',
                            decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            initialValue: signInStore.rememberData["username"],
                          ),
                          const SizedBox(height: 25),
                          Observer(builder: (_) {
                            return FormBuilderTextField(
                              name: 'password',
                              decoration: InputDecoration(
                                labelText: 'Şifre', hintText: 'Enter your password',
                                // Here is key idea
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    signInStore.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: signInStore.changePasswordVisibility,
                                ),
                              ),
                              obscureText: !signInStore.passwordVisible,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              initialValue: signInStore.rememberData["password"],
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: FormBuilderCheckbox(
                                  name: 'rememberme',
                                  title: const Text('Beni Hatırla'),
                                  initialValue: signInStore.rememberData["rememberme"],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Şifremi Unuttum',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          MaterialButton(
                            height: 50,
                            minWidth: size.width,
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () async {
                              if (_formKey.currentState?.saveAndValidate() != null && _formKey.currentState!.saveAndValidate()) {
                                debugPrint(_formKey.currentState?.value.toString());
                                AuthService authService = AuthService();

                                if (_formKey.currentState?.value != null) {
                                  onLoading(context);
                                  try {
                                    await authService.login(_formKey.currentState!.value);

                                    if (context.mounted) {
                                      toastMessage(
                                        context: context,
                                        type: ToastMessageType.success,
                                        message: 'Başarılı',
                                      );
                                      await Navigator.of(context).pushReplacementNamed('/home');
                                    }
                                  } on DioException catch (e) {
                                    log(e.toString());
                                    if (e.response != null && e.response?.statusCode == 404 && context.mounted) {
                                      toastMessage(
                                        context: context,
                                        type: ToastMessageType.warning,
                                        message: 'Kullanıcı adı veya şifre yanlış!',
                                      );
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                    if (context.mounted) {
                                      toastMessage(
                                        context: context,
                                        type: ToastMessageType.error,
                                        message: 'Beklenmedik bir hata oluştu!',
                                      );
                                    }
                                  }

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Giriş',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * .12,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
