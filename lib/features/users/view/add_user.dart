import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/post_controller.dart';
import '../../../core/utils/config/styles/colors.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController hNameController = TextEditingController();
  final TextEditingController floorSectionController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedDateText = "Select Date";

  @override
  Widget build(BuildContext context) {
    final postController = Provider.of<PostController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.borderColor),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildLeftColumn()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildRightColumn(postController)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _customBtn(
                    width: double.infinity,
                    height: 50,
                    text: "Submit",
                    onPressed: () {
                      // Handle form submission logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTextField(empIdController, "EMP ID", "Enter Employee ID", Icons.badge),
        const SizedBox(height: 16),
        _customTextField(hNameController, "H-Name", "Enter H-Name", Icons.home),
        const SizedBox(height: 16),
        _customTextField(floorSectionController, "Floor Section", "Enter Floor Section", Icons.layers),
        const SizedBox(height: 16),
        _customTextField(userIdController, "User ID", "Enter User ID", Icons.perm_identity),
      ],
    );
  }

  Widget _buildRightColumn(PostController postController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            await postController.fetchCurrentDate(context: context);
            setState(() {
              selectedDateText = postController.selected.toString().split(' ')[0]; // Display date in 'YYYY-MM-DD' format
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.borderColor, width: 1.5),
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDateText, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                const Icon(Icons.calendar_today, color: AppColor.borderColor),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _customTextField(usernameController, "Username", "Enter Username", Icons.person),
        const SizedBox(height: 16),
        _customTextField(sexController, "Sex", "Enter Sex", Icons.wc),
        const SizedBox(height: 16),
        _customTextField(designationController, "Designation", "Enter Designation", Icons.work),
        const SizedBox(height: 16),
        _customTextField(emailController, "Email", "Enter Email", Icons.email),
        const SizedBox(height: 16),
        _customTextField(mobileController, "Mobile", "Enter Mobile", Icons.phone),
        const SizedBox(height: 16),
        _customTextField(passwordController, "Password", "Enter Password", Icons.lock, obscureText: true),
      ],
    );
  }

  Widget _customTextField(TextEditingController controller, String labelTxt, String hintTxt, IconData icon, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelTxt,
        hintText: hintTxt,
        prefixIcon: Icon(icon, color: AppColor.borderColor),
        filled: true,
        fillColor: Colors.grey.shade100,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: AppColor.borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: AppColor.borderColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: AppColor.errorBorder, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget _customBtn({
    required double width,
    required double height,
    required String text,
    required Function() onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: AppColor.btnColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(text, style: const TextStyle(color: AppColor.whiteTxt)),
    );
  }
}
