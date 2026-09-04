class DailyHomeworkModel {
  final String id;
  final String studentId;
  final String studentName;
  final String teacherId;
  final DateTime date;

  // New Memorization (الجديد)
  final int newSurahNumber;
  final String newSurahName;
  final int newAyahFrom;
  final int newAyahTo;

  // Review (المراجعة)
  final int reviewSurahNumber;
  final String reviewSurahName;
  final int reviewAyahFrom;
  final int reviewAyahTo;

  final bool isCompleted;
  final String? teacherNotes;
  final int rating; // 1 to 5 stars

  const DailyHomeworkModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.teacherId,
    required this.date,
    required this.newSurahNumber,
    required this.newSurahName,
    required this.newAyahFrom,
    required this.newAyahTo,
    required this.reviewSurahNumber,
    required this.reviewSurahName,
    required this.reviewAyahFrom,
    required this.reviewAyahTo,
    this.isCompleted = false,
    this.teacherNotes,
    this.rating = 5,
  });

  String get newFormattedText =>
      "سورة $newSurahName (من الآية $newAyahFrom إلى الآية $newAyahTo)";

  String get reviewFormattedText =>
      "سورة $reviewSurahName (من الآية $reviewAyahFrom إلى الآية $reviewAyahTo)";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'teacherId': teacherId,
      'date': date.toIso8601String(),
      'newSurahNumber': newSurahNumber,
      'newSurahName': newSurahName,
      'newAyahFrom': newAyahFrom,
      'newAyahTo': newAyahTo,
      'reviewSurahNumber': reviewSurahNumber,
      'reviewSurahName': reviewSurahName,
      'reviewAyahFrom': reviewAyahFrom,
      'reviewAyahTo': reviewAyahTo,
      'isCompleted': isCompleted,
      'teacherNotes': teacherNotes,
      'rating': rating,
    };
  }

  factory DailyHomeworkModel.fromMap(Map<String, dynamic> map, String docId) {
    return DailyHomeworkModel(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      teacherId: map['teacherId'] ?? '',
      date: map['date'] != null
          ? DateTime.tryParse(map['date']) ?? DateTime.now()
          : DateTime.now(),
      newSurahNumber: map['newSurahNumber'] ?? 1,
      newSurahName: map['newSurahName'] ?? 'الفاتحة',
      newAyahFrom: map['newAyahFrom'] ?? 1,
      newAyahTo: map['newAyahTo'] ?? 7,
      reviewSurahNumber: map['reviewSurahNumber'] ?? 1,
      reviewSurahName: map['reviewSurahName'] ?? 'الفاتحة',
      reviewAyahFrom: map['reviewAyahFrom'] ?? 1,
      reviewAyahTo: map['reviewAyahTo'] ?? 7,
      isCompleted: map['isCompleted'] ?? false,
      teacherNotes: map['teacherNotes'],
      rating: map['rating'] ?? 5,
    );
  }
}

class TahfeezCircleModel {
  final String id;
  final String name;
  final String teacherId;
  final String teacherName;
  final String scheduleTime; // e.g. "يومياً بعد صلاة العصر"
  final String locationRoom;  // e.g. "القاعة الشرقية - الدور الأرضي"
  final int activeStudentsCount;
  final int maxCapacity;

  const TahfeezCircleModel({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.teacherName,
    required this.scheduleTime,
    required this.locationRoom,
    this.activeStudentsCount = 0,
    this.maxCapacity = 25,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'scheduleTime': scheduleTime,
      'locationRoom': locationRoom,
      'activeStudentsCount': activeStudentsCount,
      'maxCapacity': maxCapacity,
    };
  }

  factory TahfeezCircleModel.fromMap(Map<String, dynamic> map, String docId) {
    return TahfeezCircleModel(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      name: map['name'] ?? '',
      teacherId: map['teacherId'] ?? '',
      teacherName: map['teacherName'] ?? '',
      scheduleTime: map['scheduleTime'] ?? '',
      locationRoom: map['locationRoom'] ?? '',
      activeStudentsCount: map['activeStudentsCount'] ?? 0,
      maxCapacity: map['maxCapacity'] ?? 25,
    );
  }
}

enum ApplicationStatus {
  pending,  // قيد المراجعة
  approved, // تم القبول
  rejected, // نعتذر لعدم التوفر
}

extension ApplicationStatusExtension on ApplicationStatus {
  String get nameAr {
    switch (this) {
      case ApplicationStatus.pending:
        return 'طلبك قيد المراجعة';
      case ApplicationStatus.approved:
        return 'تم القبول بنجاح';
      case ApplicationStatus.rejected:
        return 'نعتذر، الحلقات مكتملة';
    }
  }

  static ApplicationStatus fromString(String? val) {
    switch (val) {
      case 'approved':
        return ApplicationStatus.approved;
      case 'rejected':
        return ApplicationStatus.rejected;
      case 'pending':
      default:
        return ApplicationStatus.pending;
    }
  }
}

class TahfeezApplicationModel {
  final String id;
  final String applicantId;
  final String applicantName;
  final String phone;
  final String email;
  final int age;
  final String currentMemorizationLevel; // e.g. "5 أجزاء", "مبتدئ"
  final String preferredCircleId;
  final String preferredCircleName;
  final String? preferredTime;
  final String? notes;
  final ApplicationStatus status;
  final DateTime submissionDate;
  final String? reviewedBy;
  final String? rejectionReason;

  const TahfeezApplicationModel({
    required this.id,
    required this.applicantId,
    required this.applicantName,
    required this.phone,
    required this.email,
    required this.age,
    required this.currentMemorizationLevel,
    required this.preferredCircleId,
    required this.preferredCircleName,
    this.preferredTime,
    this.notes,
    this.status = ApplicationStatus.pending,
    required this.submissionDate,
    this.reviewedBy,
    this.rejectionReason,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applicantId': applicantId,
      'applicantName': applicantName,
      'phone': phone,
      'email': email,
      'age': age,
      'currentMemorizationLevel': currentMemorizationLevel,
      'preferredCircleId': preferredCircleId,
      'preferredCircleName': preferredCircleName,
      'preferredTime': preferredTime,
      'notes': notes,
      'status': status.name,
      'submissionDate': submissionDate.toIso8601String(),
      'reviewedBy': reviewedBy,
      'rejectionReason': rejectionReason,
    };
  }

  factory TahfeezApplicationModel.fromMap(Map<String, dynamic> map, String docId) {
    return TahfeezApplicationModel(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      applicantId: map['applicantId'] ?? '',
      applicantName: map['applicantName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 15,
      currentMemorizationLevel: map['currentMemorizationLevel'] ?? 'مبتدئ',
      preferredCircleId: map['preferredCircleId'] ?? '',
      preferredCircleName: map['preferredCircleName'] ?? '',
      preferredTime: map['preferredTime'],
      notes: map['notes'],
      status: ApplicationStatusExtension.fromString(map['status']),
      submissionDate: map['submissionDate'] != null
          ? DateTime.tryParse(map['submissionDate']) ?? DateTime.now()
          : DateTime.now(),
      reviewedBy: map['reviewedBy'],
      rejectionReason: map['rejectionReason'],
    );
  }
}
