import '../../data/repositories/schedule_repository.dart';
import '../../domain/models/course.dart';
import '../core/base_view_model.dart';

class ScheduleViewModel extends BaseViewModel {
  ScheduleViewModel({
    required ScheduleRepository repository,
    DateTime Function()? now,
  }) : _repository = repository {
    final weekday = (now ?? DateTime.now)().weekday;
    // Akhir pekan -> tampilkan Senin.
    _selectedDay = weekday <= 5 ? weekday : 1;
  }

  final ScheduleRepository _repository;

  List<Course> _courses = const [];
  late int _selectedDay;

  int get selectedDay => _selectedDay;
  List<Course> get coursesForSelectedDay =>
      _courses.where((c) => c.weekday == _selectedDay).toList();

  void selectDay(int weekday) {
    _selectedDay = weekday;
    notifyListeners();
  }

  @override
  Future<void> load() => runLoad(() async {
        _courses = await _repository.getCourses();
      });
}
