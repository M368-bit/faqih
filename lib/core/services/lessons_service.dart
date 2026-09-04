import 'package:flutter/foundation.dart';
import '../../features/lessons_sermons/models/lesson_model.dart';
import 'mock_data_service.dart';

class LessonsService extends ChangeNotifier {
  List<LessonModel> _lessons = List.from(MockDataService.mockLessons);
  bool _isLoading = false;

  List<LessonModel> get lessons => List.unmodifiable(_lessons);
  bool get isLoading => _isLoading;

  /// Add new Friday sermon or lecture (Admin / Sheikh only)
  Future<bool> addLesson(LessonModel lesson) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));
    _lessons.insert(0, lesson);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Delete existing lesson or sermon (Admin / Sheikh only)
  Future<bool> deleteLesson(String lessonId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    _lessons.removeWhere((l) => l.id == lessonId);

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
