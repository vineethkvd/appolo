import 'package:appolo/features/users/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/helpers/routes/app_route_config.dart';
import 'features/dashboard/controller/dashboard_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostController(),
        ),

      ],
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: AppRoutes.router.routerDelegate,
          routeInformationParser: AppRoutes.router.routeInformationParser,
          routeInformationProvider: AppRoutes.router.routeInformationProvider,
        );
      },
    );
  }
}