// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:api_crud_dec/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await Provider.of<HomeScreenController>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    top: 20.0,
                    right: 20,
                    left: 20.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Name", border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: roleController,
                      decoration: InputDecoration(
                          hintText: "Role", border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            if (roleController.text.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              // call api to add data

                              Provider.of<HomeScreenController>(context,
                                      listen: false)
                                  .addData(
                                      name: nameController.text,
                                      role: roleController.text)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.green,
                                          content: Text("Enter valid data")));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                200,
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.red,
                                          content: Text("Failed to add data")));
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height -
                                                200,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text("Enter valid data")));
                            }
                          },
                          child: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Api Crud"),
          centerTitle: true,
        ),
        body: Consumer<HomeScreenController>(
          builder: (context, value, child) => value.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await fetchData();
                  },
                  child: ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                                child: Text(
                                    value.employeeList[index].id.toString())),
                            title:
                                Text(value.employeeList[index].name.toString()),
                            subtitle:
                                Text(value.employeeList[index].role.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 20),
                                InkWell(
                                    onTap: () {
                                      Provider.of<HomeScreenController>(context,
                                              listen: false)
                                          .deleteData(value
                                              .employeeList[index].id
                                              .toString());
                                    },
                                    child: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: value.employeeList.length),
                ),
        ));
  }
}
