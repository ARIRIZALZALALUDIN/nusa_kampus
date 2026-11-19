import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_body.dart';
import '../core/course_tile.dart';
import '../core/formatters.dart';
import '../core/section_title.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      scheduleRepository: context.read(),
      taskRepository: context.read(),
    )..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            builder: (context) {
              final today = _viewModel.today;
              final courses = _viewModel.todayCourses;
              final tasks = _viewModel.pendingTasks;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    '${dayName(today.weekday)}, ${formatDate(today)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SectionTitle('Kuliah Hari Ini'),
                  if (courses.isEmpty)
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.celebration_outlined),
                        title: Text('Tidak ada kuliah hari ini'),
                      ),
                    )
                  else
                    for (final course in courses) CourseTile(course: course),
                  SectionTitle('Tugas Belum Selesai (${tasks.length})'),
                  if (tasks.isEmpty)
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.check_circle_outline),
                        title: Text('Semua tugas sudah selesai'),
                      ),
                    )
                  else
                    for (final task in tasks)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.assignment_outlined),
                          title: Text(task.title),
                          subtitle: Text(
                            '${task.courseName}  •  Tenggat ${formatDate(task.dueDate)}',
                          ),
                        ),
                      ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
