import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/task_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';

class _FakeCampusService extends CampusService {
  @override
  Future<List<Map<String, dynamic>>> fetchTasks() async => [
        {
          'id': 't1',
          'title': 'Tugas 1',
          'courseName': 'Basis Data',
          'dueDate': '2026-11-25',
          'isDone': false,
        },
        {
          'id': 't2',
          'title': 'Tugas 2',
          'courseName': 'Jaringan',
          'dueDate': '2026-11-26',
          'isDone': false,
        },
      ];
}

void main() {
  test('setDone memindahkan tugas ke selesai dan memberi tahu listener',
      () async {
    final repository = TaskRepository(service: _FakeCampusService());
    await repository.load();
    expect(repository.pendingCount, 2);

    var notified = 0;
    repository.addListener(() => notified++);

    repository.setDone('t1', true);

    expect(repository.pendingCount, 1);
    expect(repository.doneTasks.single.id, 't1');
    expect(notified, 1);
  });
}
