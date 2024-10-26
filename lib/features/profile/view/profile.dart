import 'package:appolo/core/utils/shared/constant/assetsPathes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/config/styles/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        color: AppColor.primaryColor,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            _buildProfileHeader(h),
            const SizedBox(height: 20),
            _buildPersonalInfoTile(w), // Updated to use ExpansionTile
            const SizedBox(height: 15),
            _buildCard(
              icon: Icons.lock,
              title: 'Security',
              subtitle: 'Update your password and secure your account',
              onTap: () {
                // Add navigation or other logic here
              },
            ),
            const SizedBox(height: 15),
            _buildCard(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Manage your notification preferences',
              onTap: () {
                // Add navigation or other logic here
              },
            ),
            const SizedBox(height: 15),
            _buildCard(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'Customize your app experience',
              onTap: () {
                // Add navigation or other logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(double height) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: height * 0.06,
            backgroundImage: AssetImage(AssetsPathes.appLogo),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SUPER ADMIN',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'admin@company.com',
                style: GoogleFonts.roboto(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoTile(double width) {
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(Icons.person, color: AppColor.primaryColor, size: 30),
          title: Text(
            'Personal Information',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'View and update your details',
            style: GoogleFonts.roboto(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 15),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            _buildInfoItem('Name', 'John Doe'),
            Divider(color: Colors.grey[300]),
            _buildInfoItem('Email', 'admin@company.com'),
            Divider(color: Colors.grey[300]),
            _buildInfoItem('Phone Number', '+1 (123) 456-7890'),
            Divider(color: Colors.grey[300]),
            _buildInfoItem('Address', '123 Admin Street, Cityville'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 9.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.roboto(color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: AppColor.primaryColor),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
