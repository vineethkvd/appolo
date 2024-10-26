import 'package:flutter/material.dart';

import '../../../core/utils/config/styles/colors.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final List<Map<String, dynamic>> users = List.generate(5, (index) {
    return {
      'slNo': index + 1,
      'userId': 'UID00${index + 1}',
      'name': 'User ${index + 1}',
      'department': 'Department ${index + 1}',
      'isActive': index % 2 == 0,
    };
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: w,
        color: AppColor.primaryColor,
        padding: const EdgeInsets.all(15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Management",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildTopButton("Add User", Icons.person_add, Colors.blue, () {}),
                    const SizedBox(width: 10),
                    _buildTopButton("Download", Icons.download, Colors.green, () {}),
                    const SizedBox(width: 10),
                    _buildTopButton("Print", Icons.print, Colors.orange, () {}),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTableHeaders(),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return _buildTableRow(users[index], index % 2 == 0);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 16),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildTableHeaders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(flex: 1, child: Text('Sl No', style: _headerTextStyle)),
        Expanded(flex: 2, child: Text('User ID', style: _headerTextStyle)),
        Expanded(flex: 3, child: Text('Name', style: _headerTextStyle)),
        Expanded(flex: 3, child: Text('Department', style: _headerTextStyle)),
        Expanded(flex: 2, child: Text('Action', style: _headerTextStyle)),
      ],
    );
  }

  Widget _buildTableRow(Map<String, dynamic> user, bool isEvenRow) {
    return Container(
      color: isEvenRow ? Colors.grey.withOpacity(0.1) : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: _styledCell('${user['slNo']}')),
          Expanded(flex: 2, child: _styledCell(user['userId'])),
          Expanded(flex: 3, child: _styledCell(user['name'])),
          Expanded(flex: 3, child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _departmentCell(user['department'], user['isActive']),
          )),
          Expanded(flex: 2, child: _buildActionButtons()),
        ],
      ),
    );
  }

  Widget _styledCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _departmentCell(String department, bool isActive) {
    return Row(
      children: [
        Expanded(
          child: Text(
            department,
            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() => isActive = !isActive);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            backgroundColor: isActive ? Colors.green : Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            isActive ? 'Deactivate' : 'Activate',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _actionButton(Icons.visibility, Colors.blue, () {}),
        const SizedBox(width: 8),
        _actionButton(Icons.edit, Colors.green, () {}),
        const SizedBox(width: 8),
        _actionButton(Icons.delete, Colors.red, () {}),
      ],
    );
  }

  Widget _actionButton(IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}

const TextStyle _headerTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black87,
);
