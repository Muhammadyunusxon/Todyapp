import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Model/TodoModel.dart';
import 'package:todo_app/Pages/add_todo_page.dart';
import 'package:todo_app/Store/LocalStore.dart';

import '../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> listOfTodo = [];

  getInfo() async {
    listOfTodo = await LocalStore.getListTodo();
    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.brandColor,
        centerTitle: true,
        title: Text(
          "ToDo List",
          style: Style.textStyleSemiBold(textColor: Colors.white,),
        ),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
          itemCount: listOfTodo.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Checkbox(
                    value: listOfTodo[index].isDone,
                    onChanged: (value) {
                      listOfTodo[index].isDone = !listOfTodo[index].isDone;
                      LocalStore.setChangeStatus(listOfTodo[index], index);
                      setState(() {});
                    }),
                Text(
                  listOfTodo[index].title,
                  style:
                      Style.textStyleNormal(isDone: listOfTodo[index].isDone),
                )
              ],
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 10),
        child: GestureDetector(
          onTap: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AddTodoPage()));
          },
          child: Container(
            height: 56.r,
            width: 56.r,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              gradient: Style.primaryGradient,
              border: Border.all(color: Style.brandColor,width: 2),
            ),
            child: const Center(
                child: Icon(
              Icons.add,
              color: Colors.white,
            )),
          ),
        ),
      ),
    );
  }
}
