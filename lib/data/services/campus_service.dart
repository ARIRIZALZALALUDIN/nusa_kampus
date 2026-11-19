/// Simulasi server: mengembalikan data contoh (JSON) setelah jeda singkat.
class CampusService {
  CampusService();

  static const _delay = Duration(milliseconds: 800);

  Future<List<Map<String, dynamic>>> fetchCourses() async {
    await Future.delayed(_delay);
    return [
      {
        'id': 'c1',
        'name': 'Pemrograman Mobile',
        'lecturer': 'Dr. Rina Wijaya',
        'room': 'Lab 3.2',
        'weekday': 1,
        'startTime': '08:00',
        'endTime': '10:30',
      },
      {
        'id': 'c2',
        'name': 'Basis Data',
        'lecturer': 'Budi Santoso, M.Kom.',
        'room': 'R. 2.14',
        'weekday': 1,
        'startTime': '13:00',
        'endTime': '15:30',
      },
      {
        'id': 'c3',
        'name': 'Jaringan Komputer',
        'lecturer': 'Ir. Agus Pratama',
        'room': 'R. 2.10',
        'weekday': 2,
        'startTime': '08:00',
        'endTime': '10:00',
      },
      {
        'id': 'c4',
        'name': 'Rekayasa Perangkat Lunak',
        'lecturer': 'Sari Dewi, M.T.',
        'room': 'R. 3.05',
        'weekday': 2,
        'startTime': '10:30',
        'endTime': '12:30',
      },
      {
        'id': 'c5',
        'name': 'Praktikum Pemrograman Mobile',
        'lecturer': 'Dr. Rina Wijaya',
        'room': 'Lab 3.2',
        'weekday': 3,
        'startTime': '09:00',
        'endTime': '11:30',
      },
      {
        'id': 'c6',
        'name': 'Kecerdasan Buatan',
        'lecturer': 'Prof. Hendra Gunawan',
        'room': 'R. 4.01',
        'weekday': 3,
        'startTime': '13:00',
        'endTime': '15:00',
      },
      {
        'id': 'c7',
        'name': 'Interaksi Manusia dan Komputer',
        'lecturer': 'Maya Putri, M.Kom.',
        'room': 'R. 2.12',
        'weekday': 4,
        'startTime': '08:00',
        'endTime': '10:00',
      },
      {
        'id': 'c8',
        'name': 'Praktikum Basis Data',
        'lecturer': 'Budi Santoso, M.Kom.',
        'room': 'Lab 2.1',
        'weekday': 4,
        'startTime': '10:30',
        'endTime': '12:30',
      },
      {
        'id': 'c9',
        'name': 'Etika Profesi',
        'lecturer': 'Dewi Lestari, M.Hum.',
        'room': 'Aula B',
        'weekday': 5,
        'startTime': '09:00',
        'endTime': '10:30',
      },
      {
        'id': 'c10',
        'name': 'Keamanan Informasi',
        'lecturer': 'Ir. Agus Pratama',
        'room': 'Lab 1.1',
        'weekday': 5,
        'startTime': '13:00',
        'endTime': '15:00',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    await Future.delayed(_delay);
    return [
      {
        'id': 't1',
        'title': 'Membuat aplikasi NusaKampus',
        'courseName': 'Pemrograman Mobile',
        'dueDate': '2026-11-25',
        'isDone': false,
      },
      {
        'id': 't2',
        'title': 'Laporan praktikum ERD',
        'courseName': 'Basis Data',
        'dueDate': '2026-11-23',
        'isDone': false,
      },
      {
        'id': 't3',
        'title': 'Konfigurasi VLAN di Packet Tracer',
        'courseName': 'Jaringan Komputer',
        'dueDate': '2026-11-27',
        'isDone': false,
      },
      {
        'id': 't4',
        'title': 'Dokumen SRS kelompok',
        'courseName': 'Rekayasa Perangkat Lunak',
        'dueDate': '2026-11-30',
        'isDone': false,
      },
      {
        'id': 't5',
        'title': 'Review jurnal etika AI',
        'courseName': 'Etika Profesi',
        'dueDate': '2026-11-20',
        'isDone': true,
      },
      {
        'id': 't6',
        'title': 'Prototype aplikasi di Figma',
        'courseName': 'Interaksi Manusia dan Komputer',
        'dueDate': '2026-12-02',
        'isDone': false,
      },
    ];
  }

  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    await Future.delayed(_delay);
    return [
      {
        'id': 'a1',
        'title': 'Jadwal UAS Semester Ganjil Dirilis',
        'body':
            'Jadwal Ujian Akhir Semester sudah tersedia di portal akademik. '
                'Harap periksa bentrok jadwal dan laporkan ke bagian akademik paling lambat akhir pekan ini.',
        'author': 'Bagian Akademik',
        'date': '2026-11-17',
      },
      {
        'id': 'a2',
        'title': 'Workshop Flutter untuk Mahasiswa',
        'body':
            'Himpunan Mahasiswa Informatika mengadakan workshop Flutter gratis '
                'hari Sabtu pukul 09:00 di Lab 3.2. Pendaftaran terbuka untuk 40 peserta.',
        'author': 'HMIF',
        'date': '2026-11-15',
      },
      {
        'id': 'a3',
        'title': 'Perpustakaan Buka Lebih Lama',
        'body':
            'Selama masa persiapan ujian, perpustakaan kampus buka hingga pukul 21:00 '
                'pada hari Senin sampai Jumat.',
        'author': 'Perpustakaan',
        'date': '2026-11-12',
      },
      {
        'id': 'a4',
        'title': 'Pembayaran UKT Tahap Akhir',
        'body':
            'Batas akhir pembayaran UKT semester genap adalah 30 November 2026. '
                'Mahasiswa yang belum melunasi tidak dapat mengisi KRS.',
        'author': 'Bagian Keuangan',
        'date': '2026-11-10',
      },
      {
        'id': 'a5',
        'title': 'Pemeliharaan Wi-Fi Kampus',
        'body':
            'Jaringan Wi-Fi kampus akan dipelihara hari Minggu pukul 01:00 - 05:00. '
                'Layanan dapat terputus sementara.',
        'author': 'UPT TIK',
        'date': '2026-11-08',
      },
    ];
  }
}
