import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../controller/post_controller.dart';
import '../model/post_model.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostController>(context, listen: false).fetchPosts();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<PostController>(context, listen: false).nextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postController = Provider.of<PostController>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                    _buildTopButton("Add User", Icons.person_add, Colors.blue,
                        () {
                      context.go(RoutesPath.addUser);
                    }),
                    const SizedBox(width: 10),
                    _buildTopButton(
                        "Download", Icons.download, Colors.green, () {}),
                    const SizedBox(width: 10),
                    _buildTopButton("Print", Icons.print, Colors.orange, () {}),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTableHeaders(),
                const Divider(),
                Expanded(
                  child: postController.isLoading &&
                          postController.postList.isEmpty
                      ? _buildShimmerList()
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: postController.postList.length +
                              (postController.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == postController.postList.length) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return _buildTableRow(
                                postController.postList[index], index % 2 == 0);
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

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
        );
      },
    );
  }

  Widget _buildTopButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.appMainColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(flex: 1, child: Text('Sl No', style: _headerTextStyle)),
          Expanded(flex: 2, child: Text('User Id', style: _headerTextStyle)),
          Expanded(flex: 3, child: Text('Title', style: _headerTextStyle)),
          Expanded(flex: 3, child: Text('Content', style: _headerTextStyle)),
          Expanded(flex: 2, child: Text('Action', style: _headerTextStyle)),
        ],
      ),
    );
  }

  Widget _buildTableRow(PostModel user, bool isEvenRow) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.grey.shade100 : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: _styledCell('${user.id ?? ''}', TextAlign.center)),
          Expanded(
              flex: 2,
              child:
                  _styledCell(user.userId.toString() ?? '', TextAlign.center)),
          Expanded(
              flex: 3, child: _styledCell(user.title ?? "N/A", TextAlign.left)),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _departmentCell(user.body ?? "N/A", true),
            ),
          ),
          Expanded(flex: 2, child: _buildActionButtons()),
        ],
      ),
    );
  }

  Widget _styledCell(String text, TextAlign textAlign) {
    return Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  Widget _departmentCell(String department, bool isActive) {
    return Row(
      children: [
        Expanded(
          child: Text(
            department,
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Implement toggle active logic here
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            backgroundColor: isActive ? Colors.green : Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
  color: Colors.white,
);
