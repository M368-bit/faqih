enum UserRole {
  founderAdmin,  // مؤسس التطبيق / مدير النظام
  mosqueSheikh,  // شيخ المسجد
  quranTeacher,  // معلم التحفيظ
  student,       // طالب بالحلقة
  standardUser,  // زائر / مصلي (Default for public users)
}

extension UserRoleExtension on UserRole {
  String get code {
    switch (this) {
      case UserRole.founderAdmin:
        return 'founder_admin';
      case UserRole.mosqueSheikh:
        return 'mosque_sheikh';
      case UserRole.quranTeacher:
        return 'quran_teacher';
      case UserRole.student:
        return 'student';
      case UserRole.standardUser:
        return 'standard_user';
    }
  }

  String get roleNameAr {
    switch (this) {
      case UserRole.founderAdmin:
        return 'مؤسس التطبيق';
      case UserRole.mosqueSheikh:
        return 'شيخ المسجد';
      case UserRole.quranTeacher:
        return 'معلم التحفيظ';
      case UserRole.student:
        return 'طالب';
      case UserRole.standardUser:
        return ''; // STRICT PRIVACY RULE: Never display "شخص عادي" or "مصلي"
    }
  }

  static UserRole fromCode(String? code) {
    switch (code) {
      case 'founder_admin':
      case 'admin':
        return UserRole.founderAdmin;
      case 'mosque_sheikh':
      case 'sheikh':
        return UserRole.mosqueSheikh;
      case 'quran_teacher':
      case 'teacher':
        return UserRole.quranTeacher;
      case 'student':
        return UserRole.student;
      case 'standard_user':
      default:
        return UserRole.standardUser;
    }
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String? circleId;
  final String? circleName;
  final String? teacherId;
  final String? teacherName;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.circleId,
    this.circleName,
    this.teacherId,
    this.teacherName,
    this.photoUrl,
    required this.createdAt,
    this.isVerified = true,
  });

  /// Permissions Matrix Helpers
  bool get canManageUsers => role == UserRole.founderAdmin;
  
  bool get canOverridePrayerTimes =>
      role == UserRole.founderAdmin || role == UserRole.mosqueSheikh;

  bool get canViewUserList =>
      role == UserRole.founderAdmin || role == UserRole.mosqueSheikh;

  bool get canManageTahfeezCircle =>
      role == UserRole.founderAdmin || role == UserRole.quranTeacher;

  bool get canReviewApplications =>
      role == UserRole.founderAdmin || role == UserRole.quranTeacher;

  bool get isStudent => role == UserRole.student;

  /// Strict Privacy Check: Only non-standard users show role badges inside "حسابي"
  bool get shouldShowRoleBadgeInProfile => role != UserRole.standardUser;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.code,
      'circleId': circleId,
      'circleName': circleName,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: UserRoleExtension.fromCode(map['role']),
      circleId: map['circleId'],
      circleName: map['circleName'],
      teacherId: map['teacherId'],
      teacherName: map['teacherName'],
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      isVerified: map['isVerified'] ?? true,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? circleId,
    String? circleName,
    String? teacherId,
    String? teacherName,
    String? photoUrl,
    bool? isVerified,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      circleId: circleId ?? this.circleId,
      circleName: circleName ?? this.circleName,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
