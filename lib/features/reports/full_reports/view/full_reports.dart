import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../users/controller/post_controller.dart';
import '../../../users/model/post_model.dart';

class FullReports extends StatefulWidget {
  const FullReports({super.key});

  @override
  State<FullReports> createState() => _FullReportsState();
}

class _FullReportsState extends State<FullReports> {
  int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadPageData();
  }

  // Load the page data based on current page and rows per page
  void _loadPageData() {
    final controller = Provider.of<PostController>(context, listen: false);
    controller.dataPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PostController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.postList.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              return SingleChildScrollView(
                child: PaginatedDataTable(
                  header: const Text(
                    "Reports",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        'ID',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Title',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Body',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'User ID',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  source: _PostDataSource(controller.postList),
                  rowsPerPage: _rowsPerPage,
                  availableRowsPerPage: const [5, 10, 15, 20],
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      _rowsPerPage = value!;
                      _loadPageData();
                    });
                  },
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                      _loadPageData();
                    });
                  },
                  showFirstLastButtons: true,
                  columnSpacing: 20,
                  headingRowHeight: 50,
                  dataRowHeight: 60,
                  horizontalMargin: 10,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PostDataSource extends DataTableSource {
  final List<PostModel> postList;

  _PostDataSource(this.postList);

  @override
  DataRow? getRow(int index) {
    if (index >= postList.length) return null;
    final post = postList[index];
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>( (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.blue.withOpacity(0.1);
        }
        return null;
      }),
      cells: [
        DataCell(Text(post.id?.toString() ?? "")),
        DataCell(Text(post.title ?? "")),
        DataCell(Text(post.body ?? "")),
        DataCell(Text(post.userId?.toString() ?? "")),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Handle edit action
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Handle delete action
              },
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => postList.length;

  @override
  int get selectedRowCount => 0;
}
