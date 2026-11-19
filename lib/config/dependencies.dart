import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/announcement_repository.dart';
import '../data/repositories/schedule_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/services/campus_service.dart';

/// Daftar semua dependency aplikasi (service + repository).
/// Diambil di tempat lain dengan `context.read()`.
List<SingleChildWidget> get providers => [
      Provider<CampusService>(
        create: (_) => CampusService(),
      ),
      Provider<ScheduleRepository>(
        create: (context) =>
            ScheduleRepository(service: context.read<CampusService>()),
      ),
      // TaskRepository adalah ChangeNotifier, jadi memakai ChangeNotifierProvider.
      ChangeNotifierProvider<TaskRepository>(
        create: (context) =>
            TaskRepository(service: context.read<CampusService>()),
      ),
      Provider<AnnouncementRepository>(
        create: (context) =>
            AnnouncementRepository(service: context.read<CampusService>()),
      ),
    ];
