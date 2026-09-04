import 'package:flutter/foundation.dart';
import '../../features/tahfeez/models/tahfeez_models.dart';
import 'mock_data_service.dart';

class TahfeezService extends ChangeNotifier {
  List<TahfeezCircleModel> _circles = List.from(MockDataService.mockCircles);
  List<DailyHomeworkModel> _homeworkList = List.from(MockDataService.mockHomeworkList);
  List<TahfeezApplicationModel> _applications = List.from(MockDataService.mockApplications);
  bool _isLoading = false;

  List<TahfeezCircleModel> get circles => List.unmodifiable(_circles);
  List<DailyHomeworkModel> get homeworkList => List.unmodifiable(_homeworkList);
  List<TahfeezApplicationModel> get applications => List.unmodifiable(_applications);
  bool get isLoading => _isLoading;

  /// Get circle by ID
  TahfeezCircleModel? getCircleById(String circleId) {
    try {
      return _circles.firstWhere((c) => c.id == circleId);
    } catch (_) {
      return null;
    }
  }

  /// Get active homework for student (Auto-expires and disappears after 24 hours)
  List<DailyHomeworkModel> getHomeworkForStudent(String studentId) {
    final now = DateTime.now();
    return _homeworkList.where((h) {
      if (h.studentId != studentId) return false;
      // Auto-expire after 24 hours (86,400 seconds)
      return now.difference(h.date).inSeconds < 86400 && !now.difference(h.date).isNegative;
    }).toList();
  }

  /// Get historical homework for teacher audit logs
  List<DailyHomeworkModel> getAllHomeworkForStudent(String studentId) {
    return _homeworkList.where((h) => h.studentId == studentId).toList();
  }

  /// Get homework by teacher
  List<DailyHomeworkModel> getHomeworkByTeacher(String teacherId) {
    return _homeworkList.where((h) => h.teacherId == teacherId).toList();
  }

  /// Get application status for standard user
  TahfeezApplicationModel? getApplicationForUser(String userId) {
    try {
      return _applications.firstWhere((a) => a.applicantId == userId);
    } catch (_) {
      return null;
    }
  }

  /// Teacher / Admin: Assign Daily Homework (الجديد والمراجعة)
  Future<bool> assignHomework(DailyHomeworkModel homework) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 350));

    _homeworkList.removeWhere((h) =>
        h.studentId == homework.studentId &&
        h.date.year == homework.date.year &&
        h.date.month == homework.date.month &&
        h.date.day == homework.date.day);

    _homeworkList.insert(0, homework);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Update student completion and rating
  Future<void> updateHomeworkCompletion({
    required String homeworkId,
    required bool isCompleted,
    int? rating,
    String? teacherNotes,
  }) async {
    final index = _homeworkList.indexWhere((h) => h.id == homeworkId);
    if (index != -1) {
      final old = _homeworkList[index];
      _homeworkList[index] = DailyHomeworkModel(
        id: old.id,
        studentId: old.studentId,
        studentName: old.studentName,
        teacherId: old.teacherId,
        date: old.date,
        newSurahNumber: old.newSurahNumber,
        newSurahName: old.newSurahName,
        newAyahFrom: old.newAyahFrom,
        newAyahTo: old.newAyahTo,
        reviewSurahNumber: old.reviewSurahNumber,
        reviewSurahName: old.reviewSurahName,
        reviewAyahFrom: old.reviewAyahFrom,
        reviewAyahTo: old.reviewAyahTo,
        isCompleted: isCompleted,
        rating: rating ?? old.rating,
        teacherNotes: teacherNotes ?? old.teacherNotes,
      );
      notifyListeners();
    }
  }

  /// Standard User: Submit Tahfeez Application (No circle chosen by applicant)
  Future<bool> submitApplication(TahfeezApplicationModel application) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    _applications.removeWhere((a) => a.applicantId == application.applicantId);
    _applications.insert(0, application);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Teacher / Admin: Review and Approve/Reject Application
  /// When Approved: Auto-assigns student to target circle and adds default homework!
  Future<bool> reviewApplication({
    required String applicationId,
    required ApplicationStatus status,
    required String reviewerName,
    String? assignedCircleId,
    String? assignedCircleName,
    String? rejectionReason,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 350));

    final index = _applications.indexWhere((a) => a.id == applicationId);
    if (index != -1) {
      final old = _applications[index];
      
      final updatedApp = TahfeezApplicationModel(
        id: old.id,
        applicantId: old.applicantId,
        applicantName: old.applicantName,
        phone: old.phone,
        email: old.email,
        age: old.age,
        currentMemorizationLevel: old.currentMemorizationLevel,
        preferredCircleId: assignedCircleId ?? old.preferredCircleId,
        preferredCircleName: assignedCircleName ?? old.preferredCircleName,
        preferredTime: old.preferredTime,
        notes: old.notes,
        status: status,
        submissionDate: old.submissionDate,
        reviewedBy: reviewerName,
        rejectionReason: status == ApplicationStatus.rejected ? (rejectionReason ?? 'نعتذر لاكتمال المقاعد المتاحة') : null,
      );

      _applications[index] = updatedApp;

      // If approved, automatically create initial homework in the active circle
      if (status == ApplicationStatus.approved) {
        final newHw = DailyHomeworkModel(
          id: 'hw_${DateTime.now().millisecondsSinceEpoch}',
          studentId: old.applicantId,
          studentName: old.applicantName,
          teacherId: 'usr_teacher',
          date: DateTime.now(),
          newSurahNumber: 1,
          newSurahName: 'الفاتحة',
          newAyahFrom: 1,
          newAyahTo: 7,
          reviewSurahNumber: 114,
          reviewSurahName: 'الناس',
          reviewAyahFrom: 1,
          reviewAyahTo: 6,
          teacherNotes: 'مرحباً بك في حلقة التحفيظ، نرجو البدء بمراجعة سورة الفاتحة وأحكام التلاوة.',
          isCompleted: false,
        );
        _homeworkList.insert(0, newHw);
      }

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
