import '../../domain/models/announcement.dart';
import '../services/campus_service.dart';

class AnnouncementRepository {
  AnnouncementRepository({required CampusService service})
      : _service = service;

  final CampusService _service;

  /// Pengumuman terbaru di urutan paling atas.
  Future<List<Announcement>> getAnnouncements() async {
    final raw = await _service.fetchAnnouncements();
    return raw.map(Announcement.fromJson).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}
