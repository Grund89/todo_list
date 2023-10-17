import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';
import 'package:todo_list/pages/task_detail.page.dart';
import 'package:todo_list/widgets/add_task.widget.dart';

class TestListPage extends StatefulWidget {
  const TestListPage({super.key});

  @override
  State<TestListPage> createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  final List<Task> tasks = [];

  void addTask() async {
    final newTask = await showModalBottomSheet<Task>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AddTask(),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  void updatedTask(Task task, int index) async {
    final resultUpdate = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TaskDatailPage(
          task: task,
        ),
      ),
    );

    if (resultUpdate != null) {
      setState(() {
        if (resultUpdate is Task) {
          tasks[index] = resultUpdate;
        } else {
          tasks.removeAt(index);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) {
            final task = tasks[index];
            return Card(
              elevation: 3,
              color: Colors.indigo[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(task.title),
                subtitle:
                    task.description != null ? Text(task.description!) : null,
                leading: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      task.changeStatus(value!);
                    });
                  },
                  value: task.completed,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                trailing: IconButton(
                  icon: Icon(
                    task.important ? Icons.star : Icons.star_border,
                  ),
                  onPressed: () {
                    setState(() {
                      task.changeimportance();
                    });
                  },
                  color: Colors.indigo,
                ),
                onTap: () => updatedTask(task, index),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTask,
        label: const Text("Nova Tarefa"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
