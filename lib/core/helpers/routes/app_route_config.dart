import 'package:appolo/features/hospitals/view/hospitals.dart';
import 'package:appolo/features/profile/view/profile.dart';
import 'package:appolo/features/reports/file_reports/view/file_reports.dart';
import 'package:appolo/features/reports/full_reports/view/full_reports.dart';
import 'package:appolo/features/users/view/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/dashboard/view/dashboard.dart';
import '../../../features/home/view/dashboard_home.dart';
import '../../../features/role_access/view/role_access.dart';
import 'app_route_name.dart';
import 'app_route_path.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesPath.dashboard,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return DashboardHome(child: child); // Pass the child to the layout
        },
        routes: [

          GoRoute(
            name: RoutesName.dashboard,
            path: RoutesPath.dashboard,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const DashBoard(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.profile,
            path: RoutesPath.profile,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Profile(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.roleAccess,
            path: RoutesPath.roleAccess,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const RoleAccess(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.hospitals,
            path: RoutesPath.hospitals,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Hospitals(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.users,
            path: RoutesPath.users,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Users(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.fullReport,
            path: RoutesPath.fullReport,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const FullReports(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            name: RoutesName.fileReports,
            path: RoutesPath.fileReports,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const FileReports(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
        ],
      ),
    ],
  );
}