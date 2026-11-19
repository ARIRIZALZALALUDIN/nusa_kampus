import '../../domain/models/course.dart';
import '../services/campus_service.dart';

class ScheduleRepository {
  ScheduleRepository({required CampusService service}) : _service = service;

  final CampusService _service;
  List<Course>? _cache;

  /// Semua mata kuliah, urut berdasarkan hari lalu jam mulai.
  Future<List<Course>> getCourses() async {
    final cached = _cache;
    if (cached != null) return cached;

    final raw = await _service.fetchCourses();
    final courses = raw.map(Course.fromJson).toList()
      ..sort((a, b) {
        final byDay = a.weekday.compareTo(b.weekday);
        return byDay != 0 ? byDay : a.startTime.compareTo(b.startTime);
      });
    _cache = courses;
    return courses;
  }

  /// Mata kuliah pada hari tertentu (1 = Senin ... 7 = Minggu).
  Future<List<Course>> getCoursesForDay(int weekday) async {
    final courses = await getCourses();
    return courses.where((c) => c.weekday == weekday).toList();
  }
}
