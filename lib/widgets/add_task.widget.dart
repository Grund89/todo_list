import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleCotroller = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isImportant = false;
  var showDescription = false;

  addTask() {
    if (!formKey.currentState!.validate()) return;

    final task = Task(
      title: titleCotroller.text,
      description: descriptionController.text.isEmpty
          ? null
          : descriptionController.text,
      important: isImportant,
    );

    Navigator.of(context).pop(task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Adicionar tarefa",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              height: 0,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: titleCotroller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "O que você quer fazer hoje?",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }

                return null;
              },
            ),
            if (showDescription)
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Adicionar informações",
                ),
              ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        showDescription = true;
                      });
                    },
                    child: const Icon(
                      Icons.sort,
                    )),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImportant = !isImportant;
                    });
                  },
                  child: Icon(isImportant ? Icons.star : Icons.star_border),
                ),
                const Spacer(),
                TextButton(
                  onPressed: addTask,
                  child: const Text("Adicionar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
