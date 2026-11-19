import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/announcement_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';
import 'package:nusa_kampus/ui/announcements/announcements_view_model.dart';

class _FakeCampusService extends CampusService {
  _FakeCampusService({this.shouldFail = false});

  final bool shouldFail;

  @override
  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    if (shouldFail) throw Exception('Server error');
    return [
      {
        'id': 'a1',
        'title': 'Pengumuman Lama',
        'body': 'Isi lama',
        'author': 'Akademik',
        'date': '2026-11-01',
      },
      {
        'id': 'a2',
        'title': 'Pengumuman Baru',
        'body': 'Isi baru',
        'author': 'Akademik',
        'date': '2026-11-10',
      },
    ];
  }
}

AnnouncementsViewModel _createViewModel({bool shouldFail = false}) {
  return AnnouncementsViewModel(
    repository: AnnouncementRepository(
      service: _FakeCampusService(shouldFail: shouldFail),
    ),
  );
}

void main() {
  group('AnnouncementsViewModel', () {
    test('keadaan awal: kosong, tidak loading, tanpa error', () {
      final viewModel = _createViewModel();

      expect(viewModel.announcements, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
    });

    test('load() berhasil: isLoading true lalu false, data terurut terbaru',
        () async {
      final viewModel = _createViewModel();
      final loadingStates = <bool>[];
      viewModel.addListener(() => loadingStates.add(viewModel.isLoading));

      await viewModel.load();

      expect(loadingStates, [true, false]);
      expect(viewModel.announcements, hasLength(2));
      expect(viewModel.announcements.first.title, 'Pengumuman Baru');
      expect(viewModel.error, isNull);
    });

    test('load() gagal: error terisi dan isLoading kembali false', () async {
      final viewModel = _createViewModel(shouldFail: true);

      await viewModel.load();

      expect(viewModel.error, isNotNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.announcements, isEmpty);
    });
  });
}
