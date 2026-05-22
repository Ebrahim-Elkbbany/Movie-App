import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/movie_app.dart';
import 'package:movie_app/core/di/service_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MovieApp());
}
