import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Model/TodoModel.dart';
import 'package:todo_app/Pages/EditPage.dart';
import 'package:todo_app/Pages/add_todo_page.dart';
import 'package:todo_app/Store/LocalStore.dart';
import 'dart:io' show Platform;

import '../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<TodoModel> listOfTodo = [];
  List<TodoModel> listOfDone = [];

  @override
  void initState() {
    getInfo();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  getInfo() async {
    List<TodoModel> newList = await LocalStore.getListTodo();
    newList.forEach((element) {
      if (element.isDone) {
        listOfDone.add(element);
      } else {
        listOfTodo.add(element);
      }
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.brandColor,
        centerTitle: true,
        title: Text(
          "ToDo List",
          style: Style.textStyleSemiBold(
            textColor: Colors.white,
          ),
        ),
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Style.blackColor,
            unselectedLabelColor: Style.whiteColor,
            labelColor: Style.blackColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Todo'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.done),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Done'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.done_all),
                  ],
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
              itemCount: listOfTodo.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Style.brandColor.withOpacity(0.01),
                  highlightColor: Style.transparent,
                  onLongPress: () {
                    Platform.isIOS
                        ? showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  'Tanlang',
                                  style: Style.textStyleSemiBold(),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => EditPage(
                                                  index: index,
                                                  todo: listOfTodo[index],
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          'Edit',
                                          style: Style.textStyleNormal(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      LocalStore.removeTodo(index);
                                      listOfTodo.removeAt(index);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          'Delete',
                                          style: Style.textStyleNormal(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: Style.textStyleNormal(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                  child: Dialog(
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      width: 180.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close,color: Style.brandColor,),
                                          ),
                                          8.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) => EditPage(
                                                          index: index,
                                                          todo:
                                                          listOfTodo[index],
                                                        )),
                                                  );
                                                },
                                                child: Container(
                                                  height: 65.r,
                                                  width: 65.r,
                                                  padding: EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Style.brandColor
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Style.brandColor,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  LocalStore.removeTodo(index);
                                                  listOfTodo.removeAt(index);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    height: 65.r,
                                                    width: 65.r,
                                                    padding: EdgeInsets.all(14),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Style.brandColor
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Style.brandColor,
                                                    )),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3));
                            });
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              activeColor: Style.brandColor,
                              value: listOfTodo[index].isDone,
                              onChanged: (value) {
                                listOfTodo[index].isDone =
                                    !listOfTodo[index].isDone;
                                listOfDone.add(listOfTodo[index]);
                                LocalStore.setChangeStatus(
                                    listOfTodo[index], index);
                                listOfTodo.removeAt(index);
                                setState(() {});
                              }),
                          Text(
                            listOfTodo[index].title,
                            style: Style.textStyleNormal(
                                isDone: listOfTodo[index].isDone),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),

          ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
              itemCount: listOfDone.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: ()  {
                    Platform.isIOS
                        ? showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text(
                              'Tanlang',
                              style: Style.textStyleSemiBold(),
                            ),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => EditPage(
                                          index: index,
                                          todo: listOfDone[index],
                                        )),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  LocalStore.removeTodo(index);
                                  listOfDone.removeAt(index);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Delete',
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: Style.textStyleNormal(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                        : showDialog(
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                              child: Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  width: 180.w,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.close,color: Style.brandColor,),
                                      ),
                                      8.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) => EditPage(
                                                      index: index,
                                                      todo:
                                                      listOfDone[index],
                                                    )),
                                              );
                                            },
                                            child: Container(
                                              height: 65.r,
                                              width: 65.r,
                                              padding: EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Style.brandColor
                                                    .withOpacity(0.1),
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Style.brandColor,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              LocalStore.removeTodo(index);
                                              listOfDone.removeAt(index);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: Container(
                                                height: 65.r,
                                                width: 65.r,
                                                padding: EdgeInsets.all(14),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Style.brandColor
                                                      .withOpacity(0.1),
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Style.brandColor,
                                                )),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                              filter:  ImageFilter.blur(sigmaX: 6,sigmaY: 6),);
                        });
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              activeColor: Style.brandColor,
                              value: listOfDone[index].isDone,
                              onChanged: (value) {
                                listOfDone[index].isDone =
                                    !listOfDone[index].isDone;
                                listOfTodo.add(listOfDone[index]);
                                LocalStore.setChangeStatus(
                                    listOfDone[index], index);
                                listOfDone.removeAt(index);
                                setState(() {});
                              }),
                          Text(
                            listOfDone[index].title,
                            style: Style.textStyleNormal(
                                isDone: listOfDone[index].isDone),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18, right: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AddTodoPage()));
          },
          child: Container(
            color: Style.transparent,
            child: Stack(
              children: [
                Container(
                  height: 66.r,width: 66.r,
                  decoration: BoxDecoration(
                    gradient: Style.addGradiant,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(3.r),
                  height: 60.r,width: 60.r,
                  decoration: BoxDecoration(
                    gradient: Style.whiteGradient,
                    shape: BoxShape.circle,
                    boxShadow: Style.primaryShadow,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  height: 54.r,
                  width: 54.r,
                  child: Image.asset('assets/images/Ellipse Blur.png'),
                ),
                SizedBox(
                  height: 66.r,
                  width: 66.r,
                  child: Center(child: Icon(Icons.add,color: Style.brandColor,size: 28.r,)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
