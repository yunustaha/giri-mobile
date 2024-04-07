import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: const Text(
            'Giri',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
              tooltip: 'Setting Icon',
              onPressed: () {
                final box = Hive.box('auth');
                box.put('token', null);

                Navigator.of(context, rootNavigator: true).pushReplacementNamed('/signIn');
              },
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: const Text('Home'),
    );
  }
}
