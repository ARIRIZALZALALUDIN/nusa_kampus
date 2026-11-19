import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';
import '../services/campus_service.dart';

/// Sumber data tunggal untuk tugas. Berupa [ChangeNotifier] agar Beranda,
/// halaman Tugas, dan badge tab ikut berubah saat tugas dicentang.
class TaskRepository extends ChangeNotifier {
  TaskRepository({required CampusService service}) : _service = service;

  final CampusService _service;
  Future<void>? _loading;
  List<Task> _tasks = const [];

  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Task> get pendingTasks => _tasks.where((t) => !t.isDone).toList();
  List<Task> get doneTasks => _tasks.where((t) => t.isDone).toList();
  int get pendingCount => _tasks.where((t) => !t.isDone).length;

  /// Aman dipanggil berkali-kali (Beranda & Tugas): data hanya diambil sekali.
  Future<void> load() => _loading ??= _fetch();

  Future<void> _fetch() async {
    try {
      final raw = await _service.fetchTasks();
      _tasks = raw.map(Task.fromJson).toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      notifyListeners();
    } catch (_) {
      _loading = null; // supaya bisa dicoba lagi lewat tombol "Coba lagi"
      rethrow;
    }
  }

  void setDone(String id, bool isDone) {
    _tasks = [
      for (final task in _tasks)
        if (task.id == id) task.copyWith(isDone: isDone) else task,
    ];
    notifyListeners();
  }
}
