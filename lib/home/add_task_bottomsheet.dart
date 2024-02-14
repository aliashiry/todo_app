import 'package:flutter/material.dart';
import 'package:todo_app/theme/my_theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedData = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      color: MyTheme.blackColor,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter task title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Task Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter task description';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'please Enter Task description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Select Data',
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showCalendar();
                  },
                  child: Text(
                    '${selectedData.day}/${selectedData.month}/${selectedData.year}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primaryColor,
                    ),
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      selectedData = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {}
  }
}
