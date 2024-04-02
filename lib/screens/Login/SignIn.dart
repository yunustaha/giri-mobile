import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Giri',
                style: TextStyle(fontSize: 48),
              ),
              Column(
                children: [
                  FormBuilderTextField(
                    // key: _emailFieldKey,
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      // Validate and save the form values
                      _formKey.currentState?.saveAndValidate();
                      debugPrint(_formKey.currentState?.value.toString());
          
                      // On another side, can access all field values without saving form with instantValues
                      _formKey.currentState?.validate();
                      debugPrint(_formKey.currentState?.instantValue.toString());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
