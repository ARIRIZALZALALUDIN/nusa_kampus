import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import '../core/base_view_model.dart';

/// Menggabungkan data dari ScheduleRepository dan TaskRepository.
class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required ScheduleRepository scheduleRepository,
    required TaskRepository taskRepository,
    DateTime Function()? now,
  })  : _scheduleRepository = scheduleRepository,
        _taskRepository = taskRepository,
        _now = now ?? DateTime.now {
    // Saat tugas dicentang di halaman lain, Beranda ikut diperbarui.
    _taskRepository.addListener(notifyListeners);
  }

  final ScheduleRepository _scheduleRepository;
  final TaskRepository _taskRepository;
  final DateTime Function() _now;

  List<Course> _todayCourses = const [];

  DateTime get today => _now();
  List<Course> get todayCourses => _todayCourses;
  List<Task> get pendingTasks => _taskRepository.pendingTasks;

  @override
  Future<void> load() => runLoad(() async {
        final courses = _scheduleRepository.getCoursesForDay(_now().weekday);
        final tasks = _taskRepository.load();
        await Future.wait<void>([courses, tasks]);
        _todayCourses = await courses;
      });

  @override
  void dispose() {
    _taskRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
