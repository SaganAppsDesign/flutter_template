import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/core/di/injection_container.dart' as di;
import 'package:myapp/presentation/view/random_number_screen.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<RandomNumberViewModel>()),
      ],
      child: MaterialApp(
        title: 'Flutter MVVM Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const RandomNumberScreen(),
      ),
    );
  }
}
