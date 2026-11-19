import 'package:flutter/material.dart';

import '../../domain/models/course.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.menu_book_outlined),
        title: Text(course.name),
        subtitle: Text(
          '${course.startTime} - ${course.endTime}  •  ${course.room}\n'
          '${course.lecturer}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
