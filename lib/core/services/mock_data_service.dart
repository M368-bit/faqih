import '../../features/auth/models/user_model.dart';
import '../../features/prayer_times/models/prayer_time_model.dart';
import '../../features/tahfeez/models/tahfeez_models.dart';
import '../../features/adhkar/models/dhikr_model.dart';
import '../../features/lessons_sermons/models/lesson_model.dart';

class MockDataService {
  // Verified User Directory (Initialized with the Founder Admin Account)
  static final List<UserModel> mockUsers = [
    UserModel(
      id: 'usr_founder_mohammed',
      name: 'محمد اللواتي (المدير العام)',
      email: 'mohammedellawaty56@gmail.com',
      phone: '',
      role: UserRole.founderAdmin,
      photoUrl: null,
      createdAt: DateTime(2024, 1, 1),
    ),
  ];

  // Default Today's Prayer Schedule for Makkah Al-Mukarramah
  static DayPrayerSchedule getInitialPrayerSchedule() {
    final now = DateTime.now();
    return DayPrayerSchedule(
      hijriDate: "19 ربيع الأول 1448 هـ",
      gregorianDate: "${now.day}/${now.month}/${now.year} م",
      prayers: [
        PrayerTimeItem(
          key: 'fajr',
          nameAr: 'الفجر',
          time: '05:08 ص',
          dateTime: DateTime(now.year, now.month, now.day, 5, 8),
          iqamaDelayMinutes: 25,
          isOverridden: false,
        ),
        PrayerTimeItem(
          key: 'sunrise',
          nameAr: 'الشروق',
          time: '06:24 ص',
          dateTime: DateTime(now.year, now.month, now.day, 6, 24),
          iqamaDelayMinutes: 0,
          isOverridden: false,
        ),
        PrayerTimeItem(
          key: 'dhuhr',
          nameAr: 'الظهر',
          time: '12:28 م',
          dateTime: DateTime(now.year, now.month, now.day, 12, 28),
          iqamaDelayMinutes: 20,
          isOverridden: false,
        ),
        PrayerTimeItem(
          key: 'asr',
          nameAr: 'العصر',
          time: '03:52 م',
          dateTime: DateTime(now.year, now.month, now.day, 15, 52),
          iqamaDelayMinutes: 20,
          isOverridden: true,
        ),
        PrayerTimeItem(
          key: 'maghrib',
          nameAr: 'المغرب',
          time: '06:33 م',
          dateTime: DateTime(now.year, now.month, now.day, 18, 33),
          iqamaDelayMinutes: 10,
          isOverridden: false,
        ),
        PrayerTimeItem(
          key: 'isha',
          nameAr: 'العشاء',
          time: '08:03 م',
          dateTime: DateTime(now.year, now.month, now.day, 20, 3),
          iqamaDelayMinutes: 20,
          isOverridden: false,
        ),
      ],
      lastUpdated: now,
      updatedBySheikhName: "إمام الجامع",
      hasManualOverride: false,
    );
  }

  // Tahfeez Circles
  static final List<TahfeezCircleModel> mockCircles = [
    const TahfeezCircleModel(
      id: 'circle_nafi',
      name: 'حلقة الإمام نافع المدني',
      teacherId: '',
      teacherName: 'معلم الحلقة',
      scheduleTime: 'يومياً بعد صلاة العصر حتى المغرب',
      locationRoom: 'الرواق الشرقي - الدور الأرضي',
      activeStudentsCount: 0,
      maxCapacity: 20,
    ),
    const TahfeezCircleModel(
      id: 'circle_asim',
      name: 'حلقة الإمام عاصم الكوفي',
      teacherId: '',
      teacherName: 'معلم الحلقة',
      scheduleTime: 'يومياً بعد صلاة المغرب حتى العشاء',
      locationRoom: 'الرواق الغربي - الدور الأول',
      activeStudentsCount: 0,
      maxCapacity: 25,
    ),
    const TahfeezCircleModel(
      id: 'circle_shatibi',
      name: 'حلقة الإمام الشاطبي (المتقنين والإجازات)',
      teacherId: '',
      teacherName: 'معلم الحلقة',
      scheduleTime: 'أيام الأحد والثلاثاء والخميس بعد العصر',
      locationRoom: 'قاعة المقرأة القرآنية الإلكترونية',
      activeStudentsCount: 0,
      maxCapacity: 15,
    ),
  ];

  // Daily Homework Assignments (Empty - Live data only)
  static final List<DailyHomeworkModel> mockHomeworkList = [];

  // Tahfeez Applications (Empty - Live data only)
  static final List<TahfeezApplicationModel> mockApplications = [];

  // ==========================================
  // 1. Post-Prayer Adhkar (الأذكار بعد الصلاة المفروضة)
  // Exact source text matching Mosque standards
  // ==========================================
  static final List<DhikrItem> postPrayerAdhkar = [
    DhikrItem(
      id: 'post_1',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ.\nاللَّهُمَّ أَنْتَ السَّلَامُ، وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الجَلَالِ وَالإِكْرَامِ.',
      reward: 'يُقال دبر كل صلاة مكتوبة فور السلام.',
      source: 'صحيح مسلم [1]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_2',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الجَدِّ مِنْكَ الجَدُّ.',
      reward: 'كمال الافتقار وإخلاص التوحيد لله سبحانه.',
      source: 'متفق عليه [2]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_3',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ، لَا إِلَهَ إِلَّا اللَّهُ، وَلَا نَعْبُدُ إِلَّا إِيَّاهُ، لَهُ النِّعْمَةُ وَلَهُ الفَضْلُ وَلَهُ الثَّنَاءُ الحَسَنُ، لَا إِلَهَ إِلَّا اللَّهُ مُخْلِصِينَ لَهُ الدِّينَ وَلَوْ كَرِهَ الكَافِرُونَ.',
      reward: 'البراءة من الشرك والثناء على الله بآلائه.',
      source: 'صحيح مسلم [3]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_4',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'سُبْحَانَ اللَّهِ',
      reward: 'التسبيح ثلاثاً وثلاثين مرة بعد الصلاة.',
      source: 'صحيح مسلم [4]',
      targetCount: 33,
    ),
    DhikrItem(
      id: 'post_5',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'الحَمْدُ لِلَّهِ',
      reward: 'التحميد ثلاثاً وثلاثين مرة بعد الصلاة.',
      source: 'صحيح مسلم [4]',
      targetCount: 33,
    ),
    DhikrItem(
      id: 'post_6',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'اللَّهُ أَكْبَرُ',
      reward: 'التكبير ثلاثاً وثلاثين مرة بعد الصلاة.',
      source: 'صحيح مسلم [4]',
      targetCount: 33,
    ),
    DhikrItem(
      id: 'post_7',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ (تمام المائة)',
      reward: 'غُفِرَتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ البَحْرِ.',
      source: 'صحيح مسلم [4]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_8',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'قراءة المعوذات:\n﴿قُلْ هُوَ اللَّهُ أَحَدٌ﴾ ، ﴿قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ﴾ ، ﴿قُلْ أَعُوذُ بِرَبِّ النَّاسِ﴾',
      reward: 'تقرأ مرة بعد الظهر والعصر والعشاء، وثلاث مرات بعد الفجر والمغرب.',
      source: 'أبو داود والترمذي [5]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_9',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'قراءة آية الكرسي: قال تعالى:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾',
      reward: 'من قرأها دبر كل صلاة مكتوبة لم يمنعه من دخول الجنة إلا أن يموت.',
      source: 'رواه النسائي [6]',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'post_10',
      category: DhikrCategoryType.postPrayer,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      reward: 'تقال 10 مرات بعد صلاة المغرب والصبح قبل أن يثني رجليه.',
      source: 'مسند أحمد والترمذي [7]',
      targetCount: 10,
    ),
  ];

  // ==========================================
  // 2. Morning Adhkar (أذكار الصباح)
  // Exact Arabic texts from verified Hadith
  // ==========================================
  static final List<DhikrItem> morningAdhkar = [
    DhikrItem(
      id: 'm_1',
      category: DhikrCategoryType.morning,
      arabicText: 'أَصْبَحْنَا عَلَى فِطْرَةِ الإِسْلَامِ وَكَلِمَةِ الإِخْلَاصِ وَدِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ وَمِلَّةِ أَبِينَا إِبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.',
      reward: 'الاستمساك بالعروة الوثقى وملة التوحيد.',
      source: 'مسند أحمد',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_2',
      category: DhikrCategoryType.morning,
      arabicText: 'اللَّهُمَّ فَاطِرَ السَّمَاوَاتِ وَالأَرْضِ عَالِمَ الغَيْبِ وَالشَّهَادَةِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَشَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.',
      reward: 'الحفظ والوقاية من وساوس النفس والشيطان.',
      source: 'جامع الترمذي',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_3',
      category: DhikrCategoryType.morning,
      arabicText: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ (سيد الاستغفار).',
      reward: 'من قالها موقناً بها حين يصبح فمات دخل الجنة.',
      source: 'صحيح البخاري',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_4',
      category: DhikrCategoryType.morning,
      arabicText: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ العَرْشِ العَظِيمِ.',
      reward: 'من قالها سبع مرات كفاه الله ما أهمه من أمر دنياه وآخرته.',
      source: 'سنن أبي داود',
      targetCount: 7,
    ),
    DhikrItem(
      id: 'm_5',
      category: DhikrCategoryType.morning,
      arabicText: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتِكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.',
      reward: 'من قالها أربع مرات أعتقه الله من النار.',
      source: 'سنن أبي داود',
      targetCount: 4,
    ),
    DhikrItem(
      id: 'm_6',
      category: DhikrCategoryType.morning,
      arabicText: 'رَضِيتُ بِاللَّهِ رَبّاً، وَبِالإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيّاً.',
      reward: 'كان حقاً على الله أن يرضيه يوم القيامة.',
      source: 'سنن الترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'm_7',
      category: DhikrCategoryType.morning,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      reward: 'كانت له حرزاً من الشيطان وحطت عنه الخطايا.',
      source: 'سنن النسائي',
      targetCount: 10,
    ),
    DhikrItem(
      id: 'm_8',
      category: DhikrCategoryType.morning,
      arabicText: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ العَلِيمُ.',
      reward: 'لم يضره شيء حتى يمسي.',
      source: 'سنن أبي داود والترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'm_9',
      category: DhikrCategoryType.morning,
      arabicText: 'آية الكرسي:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾ [البقرة: 255]',
      reward: 'أجير من الجن والشياطين حتى يمسي.',
      source: 'صحيح الترغيب',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_10',
      category: DhikrCategoryType.morning,
      arabicText: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ أَبَداً.',
      reward: 'سؤال الله كمال الرعاية وتفويض الأمر إليه.',
      source: 'المستدرك على الصحيحين',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_11',
      category: DhikrCategoryType.morning,
      arabicText: 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ.',
      reward: 'التوكل والإقرار بالحشر والنشور.',
      source: 'سنن الترمذي',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_12',
      category: DhikrCategoryType.morning,
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي.',
      reward: 'دعاء جامع لحفظ الدين والنفس والأهل والمال.',
      source: 'سنن أبي داود وابن ماجه',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_13',
      category: DhikrCategoryType.morning,
      arabicText: 'أَصْبَحْنَا وَأَصْبَحَ المُلْكُ لِلَّهِ، وَالحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا اليَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ هَذَا اليَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الكَسَلِ وَسُوءِ الكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي القَبْرِ.',
      reward: 'سؤال خير اليوم والاستعاذة من شره.',
      source: 'صحيح مسلم',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'm_14',
      category: DhikrCategoryType.morning,
      arabicText: 'قراءة المعوذات:\n(قُلْ هُوَ اللَّهُ أَحَدٌ) ، (قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ) ، (قُلْ أَعُوذُ بِرَبِّ النَّاسِ)',
      reward: 'تكفيك من كل شيء.',
      source: 'سنن أبي داود والترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'm_15',
      category: DhikrCategoryType.morning,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      reward: 'كانت له عدل عشر رقاب، وكُتبت له مئة حسنة ومُحيت عنه مئة سيئة.',
      source: 'صحيح البخاري ومسلم',
      targetCount: 100,
    ),
    DhikrItem(
      id: 'm_16',
      category: DhikrCategoryType.morning,
      arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
      reward: 'حُطت خطاياه وإن كانت مثل زبد البحر.',
      source: 'صحيح مسلم',
      targetCount: 100,
    ),
  ];

  // ==========================================
  // 3. Evening Adhkar (أذكار المساء)
  // Exact Arabic texts from verified Hadith
  // ==========================================
  static final List<DhikrItem> eveningAdhkar = [
    DhikrItem(
      id: 'e_1',
      category: DhikrCategoryType.evening,
      arabicText: 'أَمْسَيْنَا عَلَى فِطْرَةِ الإِسْلَامِ وَكَلِمَةِ الإِخْلَاصِ وَدِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ وَمِلَّةِ أَبِينَا إِبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.',
      reward: 'ختام النهار على ملة الإسلام والتوحيد.',
      source: 'مسند أحمد',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_2',
      category: DhikrCategoryType.evening,
      arabicText: 'اللَّهُمَّ فَاطِرَ السَّمَاوَاتِ وَالأَرْضِ عَالِمَ الغَيْبِ وَالشَّهَادَةِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَشَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.',
      reward: 'الحفظ والوقاية من وساوس النفس والشيطان.',
      source: 'جامع الترمذي',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_3',
      category: DhikrCategoryType.evening,
      arabicText: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ (سيد الاستغفار).',
      reward: 'من قالها موقناً بها حين يمسي فمات دخل الجنة.',
      source: 'صحيح البخاري',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_4',
      category: DhikrCategoryType.evening,
      arabicText: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ العَرْشِ العَظِيمِ.',
      reward: 'من قالها سبع مرات كفاه الله ما أهمه من أمر دنياه وآخرته.',
      source: 'سنن أبي داود',
      targetCount: 7,
    ),
    DhikrItem(
      id: 'e_5',
      category: DhikrCategoryType.evening,
      arabicText: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتِكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.',
      reward: 'من قالها أربع مرات أعتقه الله من النار.',
      source: 'سنن أبي داود',
      targetCount: 4,
    ),
    DhikrItem(
      id: 'e_6',
      category: DhikrCategoryType.evening,
      arabicText: 'رَضِيتُ بِاللَّهِ رَبّاً، وَبِالإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيّاً.',
      reward: 'كان حقاً على الله أن يرضيه يوم القيامة.',
      source: 'سنن الترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'e_7',
      category: DhikrCategoryType.evening,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      reward: 'حرز من الشيطان وأجر عظيم.',
      source: 'سنن النسائي',
      targetCount: 10,
    ),
    DhikrItem(
      id: 'e_8',
      category: DhikrCategoryType.evening,
      arabicText: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ العَلِيمُ.',
      reward: 'لم يضره شيء حتى يصبح.',
      source: 'سنن أبي داود والترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'e_9',
      category: DhikrCategoryType.evening,
      arabicText: 'آية الكرسي:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾ [البقرة: 255]',
      reward: 'أجير من الجن والشياطين حتى يصبح.',
      source: 'صحيح الترغيب',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_10',
      category: DhikrCategoryType.evening,
      arabicText: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ أَبَداً.',
      reward: 'سؤال الله كمال الرعاية وتفويض الأمر إليه.',
      source: 'المستدرك على الصحيحين',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_11',
      category: DhikrCategoryType.evening,
      arabicText: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ المَصِيرُ.',
      reward: 'التوكل والإقرار بالرجوع إلى الله.',
      source: 'سنن الترمذي',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_12',
      category: DhikrCategoryType.evening,
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي.',
      reward: 'دعاء جامع للحفظ والعافية.',
      source: 'سنن أبي داود وابن ماجه',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_13',
      category: DhikrCategoryType.evening,
      arabicText: 'أَمْسَيْنَا وَأَمْسَى المُلْكُ لِلَّهِ، وَالحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الكَسَلِ وَسُوءِ الكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي القَبْرِ.',
      reward: 'سؤال خير الليلة والاستعاذة من شرها.',
      source: 'صحيح مسلم',
      targetCount: 1,
    ),
    DhikrItem(
      id: 'e_14',
      category: DhikrCategoryType.evening,
      arabicText: 'قراءة المعوذات:\n(قُلْ هُوَ اللَّهُ أَحَدٌ) ، (قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ) ، (قُلْ أَعُوذُ بِرَبِّ النَّاسِ)',
      reward: 'تكفيك من كل شيء.',
      source: 'سنن أبي داود والترمذي',
      targetCount: 3,
    ),
    DhikrItem(
      id: 'e_15',
      category: DhikrCategoryType.evening,
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
      reward: 'أجر عظيم وحط للسيئات.',
      source: 'صحيح البخاري ومسلم',
      targetCount: 100,
    ),
    DhikrItem(
      id: 'e_16',
      category: DhikrCategoryType.evening,
      arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
      reward: 'حُطت خطاياه وإن كانت مثل زبد البحر.',
      source: 'صحيح مسلم',
      targetCount: 100,
    ),
  ];

  // ==========================================
  // 4. Open General Tasbeeh (التسابيح العامة)
  // ==========================================
  static final List<DhikrItem> tasbeehAdhkar = [
    DhikrItem(
      id: 't_1',
      category: DhikrCategoryType.custom,
      arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ العَظِيمِ',
      reward: 'كلمتان خفيفتان على اللسان، ثقيلتان في الميزان، حبيبتان إلى الرحمن.',
      source: 'متفق عليه',
      targetCount: 33,
    ),
    DhikrItem(
      id: 't_2',
      category: DhikrCategoryType.custom,
      arabicText: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
      reward: 'من لزم الاستغفار جعل الله له من كل هم فرجاً ومن كل ضيق مخرجاً.',
      source: 'سنن أبي داود',
      targetCount: 100,
    ),
    DhikrItem(
      id: 't_3',
      category: DhikrCategoryType.custom,
      arabicText: 'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
      reward: 'من صلى علي صلاة صلى الله عليه بها عشراً.',
      source: 'صحيح مسلم',
      targetCount: 100,
    ),
    DhikrItem(
      id: 't_4',
      category: DhikrCategoryType.custom,
      arabicText: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ العَلِيِّ العَظِيمِ',
      reward: 'كنز من كنوز الجنة.',
      source: 'متفق عليه',
      targetCount: 33,
    ),
    DhikrItem(
      id: 't_5',
      category: DhikrCategoryType.custom,
      arabicText: 'سُبْحَانَ اللَّهِ، وَالحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ',
      reward: 'أحب الكلام إلى الله تعالى.',
      source: 'صحيح مسلم',
      targetCount: 33,
    ),
  ];

  // Lessons and Friday Sermons (Empty - Live data only)
  static final List<LessonModel> mockLessons = [];
}
