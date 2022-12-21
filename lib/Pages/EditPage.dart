import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Model/TodoModel.dart';

import '../Store/LocalStore.dart';
import '../style/style.dart';
import 'home_page.dart';

class EditPage extends StatefulWidget {
  final int index;
  final TodoModel todo;

  EditPage({Key? key, required this.index, required this.todo})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isEmpty = true;

  @override
  void initState() {
    _textEditingController.text = widget.todo.title;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.brandColor,
        title: Text(
          'Add Todo',
          style: Style.textStyleSemiBold(
            textColor: Style.whiteColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: TextFormField(
            controller: _textEditingController,
            onChanged: (value) {
              if (value.isEmpty ||
                  widget.todo.title == _textEditingController.text) {
                isEmpty = true;
              } else {
                isEmpty = false;
              }
              setState(() {});
            },
            cursorColor: Style.brandColor,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Text',
              labelStyle: Style.textStyleNormal(
                textColor: Style.brandColor,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.brandColor,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.brandColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.brandColor,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.brandColor,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: isEmpty ? Style.disableGradient : Style.primaryGradient,
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            if (_textEditingController.text.isNotEmpty &&
                _textEditingController.text != widget.todo.title) {
              LocalStore.setChangeStatus(
                  TodoModel(
                      title: _textEditingController.text,
                      isDone: widget.todo.isDone),
                  widget.index);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            }
          },
          child: Center(
            child: Text(
              'Edit',
              style: Style.textStyleNormal(textColor: Style.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
