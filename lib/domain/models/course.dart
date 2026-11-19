class Course {
  const Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.room,
    required this.weekday,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String name;
  final String lecturer;
  final String room;

  /// 1 = Senin ... 5 = Jumat (sama dengan DateTime.weekday).
  final int weekday;
  final String startTime;
  final String endTime;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      lecturer: json['lecturer'] as String,
      room: json['room'] as String,
      weekday: json['weekday'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }
}
