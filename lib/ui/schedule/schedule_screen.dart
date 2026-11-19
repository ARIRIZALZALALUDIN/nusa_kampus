import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_body.dart';
import '../core/course_tile.dart';
import '../core/formatters.dart';
import 'schedule_view_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ScheduleViewModel(repository: context.read())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            builder: (context) {
              final courses = _viewModel.coursesForSelectedDay;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<int>(
                      segments: [
                        for (var day = 1; day <= 5; day++)
                          ButtonSegment<int>(
                            value: day,
                            label: Text(shortDayName(day)),
                          ),
                      ],
                      selected: {_viewModel.selectedDay},
                      onSelectionChanged: (selection) =>
                          _viewModel.selectDay(selection.first),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    dayName(_viewModel.selectedDay),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (courses.isEmpty)
                    const Card(
                      child: ListTile(title: Text('Tidak ada kuliah')),
                    )
                  else
                    for (final course in courses) CourseTile(course: course),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
