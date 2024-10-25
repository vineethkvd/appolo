import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';

class DashboardHome extends StatefulWidget {
  final Widget? child;
  const DashboardHome({super.key, this.child});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;
        return Scaffold(
          appBar: isMobile ? _buildAppBar(context) : null,
          body: Container(
            width: w,
            height: h,
            color: Colors.white,
            child: Column(
              children: [
                _buildHeader(w, h),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: _customDrawer(ctx: context)),
                      Expanded(flex: 8, child: widget.child ?? const SizedBox.shrink()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Modern Dashboard"),
      backgroundColor: AppColor.appMainColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }

  Widget _buildHeader(double width, double height) {
    return Container(
      width: width,
      height: height * 0.10,
      color: AppColor.appMainColor,
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: const [
          Text(
            'Super Admin',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customDrawer({required BuildContext ctx}) {
    return Container(
      color: AppColor.appMainColor.withOpacity(0.95),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 250,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _buildDrawerItem(
            icon: Icons.person,
            label: 'Profile',
            onTap: () => ctx.go(RoutesPath.profile),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            onTap: () => ctx.go(RoutesPath.dashboard),
          ),
          _buildDrawerItem(
            icon: Icons.lock,
            label: 'Role Access',
            onTap: () => ctx.go(RoutesPath.roleAccess),
          ),
          _buildDrawerItem(
            icon: Icons.local_hospital_outlined,
            label: 'Hospitals',
            onTap: () => ctx.go(RoutesPath.hospitals),
          ),
          _buildDrawerItem(
            icon: Icons.credit_card_outlined,
            label: 'Users',
            onTap: () => ctx.go(RoutesPath.users),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.1),
              ),
              padding: const EdgeInsets.symmetric( horizontal: 12), // Match padding
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  leading: const Icon(Icons.credit_card_outlined, color: Colors.white),
                  title: const Text('Reports', style: TextStyle(color: Colors.white)),
                  iconColor: Colors.white,
                  tilePadding: const EdgeInsets.all(0), // Remove default padding
                  childrenPadding: const EdgeInsets.all(0), // Remove default padding
                  backgroundColor: Colors.transparent,
                  children: [
                    _buildDrawerItem(
                      icon: Icons.file_copy,
                      label: 'File Reports',
                      onTap: () => ctx.go(RoutesPath.fileReports),
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline,
                      label: 'User Reports',
                      onTap: () => ctx.go(RoutesPath.fullReport),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {
              // Add logout logic here
            },
          ),
        ],
      ),
    );
  }


  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(0.1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
