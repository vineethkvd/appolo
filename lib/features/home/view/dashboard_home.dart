import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';

class DashboardHome extends StatefulWidget {
  final Widget? child; // Made nullable to handle null cases
  const DashboardHome({super.key, this.child});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context)
        .size
        .height; // Change this to height for correct usage
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;
        return Scaffold(
          appBar: isMobile
              ? AppBar(
            title: const Text("Modern Dashboard"),
            backgroundColor: AppColor.appMainColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open Drawer on tap
                },
              ),
            ],
          )
              : null, // Hide AppBar on larger screens

          body: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  height: h * 0.10,
                  decoration:const BoxDecoration(color: AppColor.appMainColor),
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColor.primarycolor),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Dashboard Header', // Placeholder for a header
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: _drawerWidget(ctx: context)),
                          Expanded(
                              flex: 8,
                              child: Container(
                                height: h,
                               child: widget.child,
                              ))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawerWidget({required BuildContext ctx} ) {
    return Drawer(
      child: SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                context.go(RoutesPath.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                context.go(RoutesPath.dashboard);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Role Access'),
              onTap: () {
                context.go(RoutesPath.roleAccess);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital_outlined),
              title: const Text('Hospitals'),
              onTap: () {
                context.go(RoutesPath.hospitals);
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card_outlined),
              title: const Text('Users'),
              onTap: () {
                context.go(RoutesPath.users);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.credit_card_outlined),
              title: const Text('Reports'),
              backgroundColor: Colors.yellow,
              children: [
                ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('File Reports'),
                  onTap: () {

                    context.go(RoutesPath.fileReports);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('User Reports'),
                  onTap: () {
                    context.go(RoutesPath.fullReport);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Logout'),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
