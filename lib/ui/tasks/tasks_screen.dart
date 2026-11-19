import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/task.dart';
import '../core/async_body.dart';
import '../core/formatters.dart';
import '../core/section_title.dart';
import 'tasks_view_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TasksViewModel(repository: context.read())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _taskTile(Task task) {
    return Card(
      child: CheckboxListTile(
        value: task.isDone,
        onChanged: (value) => _viewModel.toggle(task, value ?? false),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          task.title,
          style: task.isDone
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(
          '${task.courseName}  •  Tenggat ${formatDate(task.dueDate)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            builder: (context) {
              final pending = _viewModel.pendingTasks;
              final done = _viewModel.doneTasks;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionTitle('Belum Selesai (${pending.length})'),
                  if (pending.isEmpty)
                    const Card(
                      child: ListTile(title: Text('Tidak ada tugas tersisa')),
                    )
                  else
                    for (final task in pending) _taskTile(task),
                  SectionTitle('Selesai (${done.length})'),
                  if (done.isEmpty)
                    const Card(
                      child: ListTile(title: Text('Belum ada tugas selesai')),
                    )
                  else
                    for (final task in done) _taskTile(task),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
