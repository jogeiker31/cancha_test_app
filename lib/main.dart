import 'package:canchas_test_app/core/repository/api_repository.dart';
import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/modules/home/home.dart';
import 'package:canchas_test_app/presentation/presentation.dart';
import 'package:flutter/material.dart';
import "package:hive/hive.dart";
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => HomeService(SchedulingRepository(), ApiRepository()))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.theme,
        initialRoute: HomeView.route,
        routes: {
          HomeView.route: (context) => const HomeView(),
          AddSchedulingView.route: (context) => const AddSchedulingView()
        });
  }
}
