/**
 * جامع الشيخ عبد القادر فقيه بمكة المكرمة
 * Web Dashboard, Security Engine & Interactive Prototype 2026
 */

// 1. Full Quran Surahs Database (114 Surahs)
const quranSurahs = [
  { num: 1, name: "الفاتحة", verses: 7, juz: 1 },
  { num: 2, name: "البقرة", verses: 286, juz: 1 },
  { num: 3, name: "آل عمران", verses: 200, juz: 3 },
  { num: 4, name: "النساء", verses: 176, juz: 4 },
  { num: 5, name: "المائدة", verses: 120, juz: 6 },
  { num: 6, name: "الأنعام", verses: 165, juz: 7 },
  { num: 7, name: "الأعراف", verses: 206, juz: 8 },
  { num: 8, name: "الأنفال", verses: 75, juz: 9 },
  { num: 9, name: "التوبة", verses: 129, juz: 10 },
  { num: 10, name: "يونس", verses: 109, juz: 11 },
  { num: 11, name: "هود", verses: 123, juz: 11 },
  { num: 12, name: "يوسف", verses: 111, juz: 12 },
  { num: 13, name: "الرعد", verses: 43, juz: 13 },
  { num: 14, name: "إبراهيم", verses: 52, juz: 13 },
  { num: 15, name: "الحجر", verses: 99, juz: 14 },
  { num: 16, name: "النحل", verses: 128, juz: 14 },
  { num: 17, name: "الإسراء", verses: 111, juz: 15 },
  { num: 18, name: "الكهف", verses: 110, juz: 15 },
  { num: 19, name: "مريم", verses: 98, juz: 16 },
  { num: 20, name: "طه", verses: 135, juz: 16 },
  { num: 21, name: "الأنبياء", verses: 112, juz: 17 },
  { num: 22, name: "الحج", verses: 78, juz: 17 },
  { num: 23, name: "المؤمنون", verses: 118, juz: 18 },
  { num: 24, name: "النور", verses: 64, juz: 18 },
  { num: 25, name: "الفرقان", verses: 77, juz: 18 },
  { num: 26, name: "الشعراء", verses: 227, juz: 19 },
  { num: 27, name: "النمل", verses: 93, juz: 19 },
  { num: 28, name: "القصص", verses: 88, juz: 20 },
  { num: 29, name: "العنكبوت", verses: 69, juz: 20 },
  { num: 30, name: "الروم", verses: 60, juz: 21 },
  { num: 31, name: "لقمان", verses: 34, juz: 21 },
  { num: 32, name: "السجدة", verses: 30, juz: 21 },
  { num: 33, name: "الأحزاب", verses: 73, juz: 21 },
  { num: 34, name: "سبأ", verses: 54, juz: 22 },
  { num: 35, name: "فاطر", verses: 45, juz: 22 },
  { num: 36, name: "يس", verses: 83, juz: 22 },
  { num: 37, name: "الصافات", verses: 182, juz: 23 },
  { num: 38, name: "ص", verses: 88, juz: 23 },
  { num: 39, name: "الزمر", verses: 75, juz: 23 },
  { num: 40, name: "غافر", verses: 85, juz: 24 },
  { num: 41, name: "فصلت", verses: 54, juz: 24 },
  { num: 42, name: "الشورى", verses: 53, juz: 25 },
  { num: 43, name: "الزخرف", verses: 89, juz: 25 },
  { num: 44, name: "الدخان", verses: 59, juz: 25 },
  { num: 45, name: "الجاثية", verses: 37, juz: 25 },
  { num: 46, name: "الأحقاف", verses: 35, juz: 26 },
  { num: 47, name: "محمد", verses: 38, juz: 26 },
  { num: 48, name: "الفتح", verses: 29, juz: 26 },
  { num: 49, name: "الحجرات", verses: 18, juz: 26 },
  { num: 50, name: "ق", verses: 45, juz: 26 },
  { num: 51, name: "الذاريات", verses: 60, juz: 26 },
  { num: 52, name: "الطور", verses: 49, juz: 27 },
  { num: 53, name: "النجم", verses: 62, juz: 27 },
  { num: 54, name: "القمر", verses: 55, juz: 27 },
  { num: 55, name: "الرحمن", verses: 78, juz: 27 },
  { num: 56, name: "الواقعة", verses: 96, juz: 27 },
  { num: 57, name: "الحديد", verses: 29, juz: 27 },
  { num: 58, name: "المجادلة", verses: 22, juz: 28 },
  { num: 59, name: "الحشر", verses: 24, juz: 28 },
  { num: 60, name: "الممتحنة", verses: 13, juz: 28 },
  { num: 61, name: "الصف", verses: 14, juz: 28 },
  { num: 62, name: "الجمعة", verses: 11, juz: 28 },
  { num: 63, name: "المنافقون", verses: 11, juz: 28 },
  { num: 64, name: "التغابن", verses: 18, juz: 28 },
  { num: 65, name: "الطلاق", verses: 12, juz: 28 },
  { num: 66, name: "التحريم", verses: 12, juz: 28 },
  { num: 67, name: "الملك", verses: 30, juz: 29 },
  { num: 68, name: "القلم", verses: 52, juz: 29 },
  { num: 69, name: "الحاقة", verses: 52, juz: 29 },
  { num: 70, name: "المعارج", verses: 44, juz: 29 },
  { num: 71, name: "نوح", verses: 28, juz: 29 },
  { num: 72, name: "الجن", verses: 28, juz: 29 },
  { num: 73, name: "المزمل", verses: 20, juz: 29 },
  { num: 74, name: "المدثر", verses: 56, juz: 29 },
  { num: 75, name: "القيامة", verses: 40, juz: 29 },
  { num: 76, name: "الإنسان", verses: 31, juz: 29 },
  { num: 77, name: "المرسلات", verses: 50, juz: 29 },
  { num: 78, name: "النبأ", verses: 40, juz: 30 },
  { num: 79, name: "النازعات", verses: 46, juz: 30 },
  { num: 80, name: "عبس", verses: 42, juz: 30 },
  { num: 81, name: "التكوير", verses: 29, juz: 30 },
  { num: 82, name: "الانفطار", verses: 19, juz: 30 },
  { num: 83, name: "المطففين", verses: 36, juz: 30 },
  { num: 84, name: "الانشقاق", verses: 25, juz: 30 },
  { num: 85, name: "البروج", verses: 22, juz: 30 },
  { num: 86, name: "الطارق", verses: 17, juz: 30 },
  { num: 87, name: "الأعلى", verses: 19, juz: 30 },
  { num: 88, name: "الغاشية", verses: 26, juz: 30 },
  { num: 89, name: "الفجر", verses: 30, juz: 30 },
  { num: 90, name: "البلد", verses: 20, juz: 30 },
  { num: 91, name: "الشمس", verses: 15, juz: 30 },
  { num: 92, name: "الليل", verses: 21, juz: 30 },
  { num: 93, name: "الضحى", verses: 11, juz: 30 },
  { num: 94, name: "الشرح", verses: 8, juz: 30 },
  { num: 95, name: "التين", verses: 8, juz: 30 },
  { num: 96, name: "العلق", verses: 19, juz: 30 },
  { num: 97, name: "القدر", verses: 5, juz: 30 },
  { num: 98, name: "البينة", verses: 8, juz: 30 },
  { num: 99, name: "الزلزلة", verses: 8, juz: 30 },
  { num: 100, name: "العاديات", verses: 11, juz: 30 },
  { num: 101, name: "القارعة", verses: 11, juz: 30 },
  { num: 102, name: "التكاثر", verses: 8, juz: 30 },
  { num: 103, name: "العصر", verses: 3, juz: 30 },
  { num: 104, name: "الهمزة", verses: 9, juz: 30 },
  { num: 105, name: "الفيل", verses: 5, juz: 30 },
  { num: 106, name: "قريش", verses: 4, juz: 30 },
  { num: 107, name: "الماعون", verses: 7, juz: 30 },
  { num: 108, name: "الكوثر", verses: 3, juz: 30 },
  { num: 109, name: "الكافرون", verses: 6, juz: 30 },
  { num: 110, name: "النصر", verses: 3, juz: 30 },
  { num: 111, name: "المسد", verses: 5, juz: 30 },
  { num: 112, name: "الإخلاص", verses: 4, juz: 30 },
  { num: 113, name: "الفلق", verses: 5, juz: 30 },
  { num: 114, name: "الناس", verses: 6, juz: 30 }
];

// Available Tahfeez Circles in the Mosque
const mosqueCircles = [
  { id: 'circle_1', name: 'حلقة الإمام نافع المدني (بعد العصر)', teacher: 'الشيخ حمزة بن عبدالله القرشي', schedule: 'يومياً بعد صلاة العصر' },
  { id: 'circle_2', name: 'حلقة الإمام عاصم الكوفي (بعد المغرب)', teacher: 'الشيخ عبدالرحمن المكي', schedule: 'يومياً بعد صلاة المغرب' },
  { id: 'circle_3', name: 'حلقة الإمام الشاطبي للمتقنين والإجازات', teacher: 'فضيلة الشيخ د. ماهر السلمي', schedule: 'أيام السبت والاثنين والأربعاء' }
];

// Full Hadith Adhkar Datasets
const postPrayerAdhkarData = [
  { id: 'p1', text: 'أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ.\nاللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الجَلَالِ وَالإِكْرَامِ.', source: 'صحيح مسلم [1]', reward: 'يُقال دبر كل صلاة مكتوبة فور السلام.', target: 1 },
  { id: 'p2', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الجَدِّ مِنْكَ الجَدُّ.', source: 'متفق عليه [2]', reward: 'كمال الافتقار وإخلاص التوحيد لله سبحانه.', target: 1 },
  { id: 'p3', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ، لَا إِلَهَ إِلَّا اللَّهُ، وَلَا نَعْبُدُ إِلَّا إِيَّاهُ، لَهُ النِّعْمَةُ وَلَهُ الفَضْلُ وَلَهُ الثَّنَاءُ الحَسَنُ، لَا إِلَهَ إِلَّا اللَّهُ مُخْلِصِينَ لَهُ الدِّينَ وَلَوْ كَرِهَ الكَافِرُونَ.', source: 'صحيح مسلم [3]', reward: 'البراءة من الشرك والثناء على الله بآلائه.', target: 1 },
  { id: 'p4', text: 'سُبْحَانَ اللَّهِ', source: 'صحيح مسلم [4]', reward: 'التسبيح 33 مرة بعد الصلاة.', target: 33 },
  { id: 'p5', text: 'الحَمْدُ لِلَّهِ', source: 'صحيح مسلم [4]', reward: 'التحميد 33 مرة بعد الصلاة.', target: 33 },
  { id: 'p6', text: 'اللَّهُ أَكْبَرُ', source: 'صحيح مسلم [4]', reward: 'التكبير 33 مرة بعد الصلاة.', target: 33 },
  { id: 'p7', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ (تمام المائة)', source: 'صحيح مسلم [4]', reward: 'غُفِرَتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ البَحْرِ.', target: 1 },
  { id: 'p8', text: 'قراءة المعوذات:\n﴿قُلْ هُوَ اللَّهُ أَحَدٌ﴾ ، ﴿قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ﴾ ، ﴿قُلْ أَعُوذُ بِرَبِّ النَّاسِ﴾', source: 'أبو داود والترمذي [5]', reward: 'تقرأ مرة بعد الظهر والعصر والعشاء، و3 مرات بعد الفجر والمغرب.', target: 1 },
  { id: 'p9', text: 'قراءة آية الكرسي: قال تعالى:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾', source: 'رواه النسائي [6]', reward: 'من قرأها دبر كل صلاة مكتوبة لم يمنعه من دخول الجنة إلا أن يموت.', target: 1 },
  { id: 'p10', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', source: 'مسند أحمد والترمذي [7]', reward: 'تقال 10 مرات بعد صلاة المغرب والصبح قبل أن يثني رجليه.', target: 10 }
];

const morningAdhkarData = [
  { id: 'm1', text: 'أَصْبَحْنَا عَلَى فِطْرَةِ الإِسْلَامِ وَكَلِمَةِ الإِخْلَاصِ وَدِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ وَمِلَّةِ أَبِينَا إِبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.', source: 'مسند أحمد', reward: 'الاستمساك بالعروة الوثقى وملة التوحيد.', target: 1 },
  { id: 'm2', text: 'اللَّهُمَّ فَاطِرَ السَّمَاوَاتِ وَالأَرْضِ عَالِمَ الغَيْبِ وَالشَّهَادَةِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَشَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.', source: 'جامع الترمذي', reward: 'الحفظ والوقاية من وساوس النفس والشيطان.', target: 1 },
  { id: 'm3', text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ (سيد الاستغفار).', source: 'صحيح البخاري', reward: 'من قالها موقناً بها حين يصبح فمات دخل الجنة.', target: 1 },
  { id: 'm4', text: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ العَرْشِ العَظِيمِ.', source: 'سنن أبي داود', reward: 'من قالها 7 مرات كفاه الله ما أهمه من أمر دنياه وآخرته.', target: 7 },
  { id: 'm5', text: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتِكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.', source: 'سنن أبي داود', reward: 'من قالها 4 مرات أعتقه الله من النار.', target: 4 },
  { id: 'm6', text: 'رَضِيتُ بِاللَّهِ رَبّاً، وَبِالإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيّاً.', source: 'سنن الترمذي', reward: 'كان حقاً على الله أن يرضيه يوم القيامة.', target: 3 },
  { id: 'm7', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', source: 'سنن النسائي', reward: 'كانت له حرزاً من الشيطان وحطت عنه الخطايا.', target: 10 },
  { id: 'm8', text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ العَلِيمُ.', source: 'سنن أبي داود', reward: 'لم يضره شيء حتى يمسي.', target: 3 },
  { id: 'm9', text: 'آية الكرسي:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ...﴾ [البقرة: 255]', source: 'صحيح الترغيب', reward: 'أجير من الجن والشياطين حتى يمسي.', target: 1 },
  { id: 'm10', text: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ أَبَداً.', source: 'المستدرك على الصحيحين', reward: 'سؤال الله كمال الرعاية وتفويض الأمر إليه.', target: 1 },
  { id: 'm11', text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ.', source: 'سنن الترمذي', reward: 'التوكل والإقرار بالحشر والنشور.', target: 1 },
  { id: 'm12', text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي.', source: 'سنن أبي داود', reward: 'دعاء جامع لحفظ الدين والنفس والأهل والمال.', target: 1 },
  { id: 'm13', text: 'أَصْبَحْنَا وَأَصْبَحَ المُلْكُ لِلَّهِ، وَالحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا اليَوْمِ وَخَيْرَ مَا بَعْدَهُ...', source: 'صحيح مسلم', reward: 'سؤال خير اليوم والاستعاذة من شره.', target: 1 },
  { id: 'm14', text: 'قراءة المعوذات:\n(قُلْ هُوَ اللَّهُ أَحَدٌ) ، (قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ) ، (قُلْ أَعُوذُ بِرَبِّ النَّاسِ)', source: 'سنن الترمذي', reward: 'تكفيك من كل شيء.', target: 3 },
  { id: 'm15', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', source: 'صحيح البخاري', reward: 'حطت عنه مئة سيئة وكُتبت له مئة حسنة.', target: 100 },
  { id: 'm16', text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.', source: 'صحيح مسلم', reward: 'حُطت خطاياه وإن كانت مثل زبد البحر.', target: 100 }
];

const eveningAdhkarData = [
  { id: 'e1', text: 'أَمْسَيْنَا عَلَى فِطْرَةِ الإِسْلَامِ وَكَلِمَةِ الإِخْلَاصِ وَدِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ وَمِلَّةِ أَبِينَا إِبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.', source: 'مسند أحمد', reward: 'ختام النهار على ملة الإسلام والتوحيد.', target: 1 },
  { id: 'e2', text: 'اللَّهُمَّ فَاطِرَ السَّمَاوَاتِ وَالأَرْضِ عَالِمَ الغَيْبِ وَالشَّهَادَةِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَشَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.', source: 'جامع الترمذي', reward: 'الحفظ والوقاية من وساوس النفس والشيطان.', target: 1 },
  { id: 'e3', text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ (سيد الاستغفار).', source: 'صحيح البخاري', reward: 'من قالها موقناً بها حين يمسي فمات دخل الجنة.', target: 1 },
  { id: 'e4', text: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ العَرْشِ العَظِيمِ.', source: 'سنن أبي داود', reward: 'من قالها 7 مرات كفاه الله ما أهمه.', target: 7 },
  { id: 'e5', text: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتِكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.', source: 'سنن أبي داود', reward: 'من قالها 4 مرات أعتقه الله من النار.', target: 4 },
  { id: 'e6', text: 'رَضِيتُ بِاللَّهِ رَبّاً، وَبِالإِسْلَامِ دِيناً، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيّاً.', source: 'سنن الترمذي', reward: 'كان حقاً على الله أن يرضيه يوم القيامة.', target: 3 },
  { id: 'e7', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', source: 'سنن النسائي', reward: 'حرز من الشيطان وأجر عظيم.', target: 10 },
  { id: 'e8', text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ العَلِيمُ.', source: 'سنن أبي داود', reward: 'لم يضره شيء حتى يصبح.', target: 3 },
  { id: 'e9', text: 'آية الكرسي:\n﴿اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ...﴾ [البقرة: 255]', source: 'صحيح الترغيب', reward: 'أجير من الشيطان حتى يصبح.', target: 1 },
  { id: 'e10', text: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ أَبَداً.', source: 'المستدرك على الصحيحين', reward: 'سؤال الله كمال الرعاية.', target: 1 },
  { id: 'e11', text: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ المَصِيرُ.', source: 'سنن الترمذي', reward: 'التوكل والإقرار بالرجوع إلى الله.', target: 1 },
  { id: 'e12', text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ العَفْوَ وَالعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي...', source: 'سنن أبي داود', reward: 'دعاء جامع للحفظ والعافية.', target: 1 },
  { id: 'e13', text: 'أَمْسَيْنَا وَأَمْسَى المُلْكُ لِلَّهِ، وَالحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ...', source: 'صحيح مسلم', reward: 'سؤال خير الليلة والاستعاذة من شرها.', target: 1 },
  { id: 'e14', text: 'قراءة المعوذات:\n(قُلْ هُوَ اللَّهُ أَحَدٌ) ، (قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ) ، (قُلْ أَعُوذُ بِرَبِّ النَّاسِ)', source: 'سنن الترمذي', reward: 'تكفيك من كل شيء.', target: 3 },
  { id: 'e15', text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ المُلْكُ وَلَهُ الحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', source: 'صحيح البخاري', reward: 'أجر عظيم وحط للسيئات.', target: 100 },
  { id: 'e16', text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.', source: 'صحيح مسلم', reward: 'حُطت خطاياه وإن كانت مثل زبد البحر.', target: 100 }
];

const tasbeehAdhkarData = [
  { id: 't1', text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ العَظِيمِ', source: 'متفق عليه', reward: 'كلمتان خفيفتان على اللسان ثقيلتان في الميزان.', target: 33 },
  { id: 't2', text: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ', source: 'سنن أبي داود', reward: 'تفريح الهموم ومغفرة الذنوب.', target: 100 },
  { id: 't3', text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى نَبِيِّنَا مُحَمَّدٍ', source: 'صحيح مسلم', reward: 'من صلى علي صلاة صلى الله عليه بها عشراً.', target: 100 },
  { id: 't4', text: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ العَلِيِّ العَظِيمِ', source: 'متفق عليه', reward: 'كنز من كنوز الجنة.', target: 33 },
  { id: 't5', text: 'سُبْحَانَ اللَّهِ، وَالحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا اللَّهُ، وَاللَّهُ أَكْبَرُ', source: 'صحيح مسلم', reward: 'أحب الكلام إلى الله تعالى.', target: 33 }
];

// 2. Global State Engine
const appState = {
  isAuthenticated: false, // Mandatory Auth Lock Flag
  currentRole: 'standard_user',
  currentUser: null,
  theme: 'light',
  
  // Interactive Step Adhkar State
  adhkarCategory: 'auto',
  adhkarCurrentIndex: 0,
  adhkarCurrentCount: 0,

  surahPickerTarget: 'new',
  selectedRegLevel: '5 أجزاء',
  memorizedAjzaaCount: 5,

  // Users Database (Clean system - only founder email auto-recognized)
  users: [
    { id: 'usr_founder_mohammed', name: 'محمد اللواتي (المدير العام)', email: 'mohammedellawaty56@gmail.com', phone: '', role: 'founder_admin' }
  ],

  // Prayer Times in Makkah
  prayers: [
    { key: 'fajr', nameAr: 'الفجر', time: '05:08 ص', iqama: 25, isOverridden: false },
    { key: 'sunrise', nameAr: 'الشروق', time: '06:24 ص', iqama: 0, isOverridden: false },
    { key: 'dhuhr', nameAr: 'الظهر', time: '12:28 م', iqama: 20, isOverridden: false },
    { key: 'asr', nameAr: 'العصر', time: '03:52 م', iqama: 20, isOverridden: true },
    { key: 'maghrib', nameAr: 'المغرب', time: '06:33 م', iqama: 10, isOverridden: false },
    { key: 'isha', nameAr: 'العشاء', time: '08:03 م', iqama: 20, isOverridden: false }
  ],

  // Clean Real-time Collections (No Fake / Mock Data)
  students: [],
  applications: [],
  lessons: []
};

// 3. Splash Screen Animation Engine
function initSplashAnimation() {
  const overlay = document.getElementById('splash-overlay');
  const container = document.getElementById('splash-container');
  if (!overlay || !container) return;

  // Step 1: Stroke Drawing (1.4s)
  // Step 2 & 3: Slide & Typography Reveal after 1.4s
  setTimeout(() => {
    container.classList.add('slid');
  }, 1400);

  // Step 4: Fade out splash overlay after 2.6s
  setTimeout(() => {
    overlay.classList.add('hidden');
    checkAuthGate();
  }, 2600);
}

function replaySplashAnimation() {
  const overlay = document.getElementById('splash-overlay');
  const container = document.getElementById('splash-container');
  if (!overlay || !container) return;

  overlay.classList.remove('hidden');
  container.classList.remove('slid');

  const svg = container.querySelector('.splash-mosque-svg');
  if (svg) {
    const clone = svg.cloneNode(true);
    svg.parentNode.replaceChild(clone, svg);
  }

  setTimeout(() => {
    container.classList.add('slid');
  }, 1400);

  setTimeout(() => {
    overlay.classList.add('hidden');
  }, 2600);
}

// 4. Mandatory Authentication Gate Logic (With Persistent Device Session)
function checkAuthGate() {
  const gate = document.getElementById('auth-gate-screen');
  if (!gate) return;

  try {
    const saved = localStorage.getItem('faqih_mosque_session_v1');
    if (saved) {
      const user = JSON.parse(saved);
      if (user && user.email) {
        authenticateUser(user, false);
        gate.classList.add('hidden');
        return;
      }
    }
  } catch (_) {}

  if (!appState.isAuthenticated) {
    gate.classList.remove('hidden');
  } else {
    gate.classList.add('hidden');
  }
}

function switchAuthMode(mode) {
  const loginForm = document.getElementById('auth-login-form');
  const regForm = document.getElementById('auth-register-form');
  const loginBtn = document.getElementById('tab-login-btn');
  const regBtn = document.getElementById('tab-register-btn');

  if (mode === 'login') {
    loginForm.style.display = 'block';
    regForm.style.display = 'none';
    loginBtn.classList.add('active');
    regBtn.classList.remove('active');
  } else {
    loginForm.style.display = 'none';
    regForm.style.display = 'block';
    loginBtn.classList.remove('active');
    regBtn.classList.add('active');
  }
}

function checkAuthPasswordStrength(pass, meterId) {
  const meter = document.getElementById(meterId);
  if (!meter) return;

  const hasUpper = /[A-Z]/.test(pass);
  const hasLower = /[a-z]/.test(pass);
  const hasDigit = /[0-9]/.test(pass);
  const hasSpecial = /[!@#$%^&*()]/.test(pass);
  const isLong = pass.length >= 8;

  if (isLong && hasUpper && hasLower && hasDigit && hasSpecial) {
    meter.innerText = "قوة كلمة المرور: ممتازة وفائقة الأمان ✓✓";
    meter.style.color = "var(--success)";
  } else if (isLong && (hasUpper || hasDigit)) {
    meter.innerText = "قوة كلمة المرور: متوسطة (أضف رموزاً خاصة)";
    meter.style.color = "var(--warning)";
  } else {
    meter.innerText = "قوة كلمة المرور: ضعيفة (تتطلب 8 أحرف وأرقام ورموز)";
    meter.style.color = "var(--error)";
  }
}

const FOUNDER_ADMIN_EMAIL = "mohammedellawaty56@gmail.com";

function handleAuthLogin(event) {
  event.preventDefault();
  const email = document.getElementById('login-email').value.trim();
  const isFounder = email.toLowerCase() === FOUNDER_ADMIN_EMAIL.toLowerCase();

  let user = appState.users.find(u => u.email.toLowerCase() === email.toLowerCase());
  if (!user) {
    const defaultName = isFounder ? 'محمد اللواتي (المدير العام)' : email.split('@')[0];
    user = {
      id: isFounder ? 'usr_founder_mohammed' : `usr_${Date.now()}`,
      name: defaultName,
      email: email,
      phone: '',
      role: isFounder ? 'founder_admin' : 'standard_user'
    };
    appState.users.push(user);
  } else if (isFounder && user.role !== 'founder_admin') {
    user.role = 'founder_admin';
    user.name = 'محمد اللواتي (المدير العام)';
  }

  authenticateUser(user);
}

function handleAuthRegister(event) {
  event.preventDefault();
  const name = document.getElementById('reg-name').value.trim();
  const phone = document.getElementById('reg-phone').value.trim();
  const email = document.getElementById('reg-email').value.trim();
  const isFounder = email.toLowerCase() === FOUNDER_ADMIN_EMAIL.toLowerCase();

  const newUser = {
    id: isFounder ? 'usr_founder_mohammed' : `usr_${Date.now()}`,
    name: isFounder ? 'محمد اللواتي (المدير العام)' : name,
    email: email,
    phone: phone,
    role: isFounder ? 'founder_admin' : 'standard_user'
  };

  appState.users.push(newUser);
  authenticateUser(newUser);
  showToast(`مرحباً بك يا ${newUser.name}! تم إنشاء حسابك بنجاح.`);
}

function authenticateUser(user, showGreeting = true) {
  appState.currentUser = user;
  appState.currentRole = user.role;
  appState.isAuthenticated = true;

  // Persist session locally on device
  try {
    localStorage.setItem('faqih_mosque_session_v1', JSON.stringify(user));
  } catch (_) {}

  // Hide Lock Gate
  const gate = document.getElementById('auth-gate-screen');
  if (gate) gate.classList.add('hidden');

  // Update Header UI
  updateHeaderUserInfo();
  renderTahfeezModule();
  renderLessonsList();
  renderProfileModule();
  renderAdminControls();

  if (showGreeting) {
    showToast(`أهلاً بك: ${user.name}`);
  }
}

function logoutToGate() {
  try {
    localStorage.removeItem('faqih_mosque_session_v1');
  } catch (_) {}
  appState.currentUser = null;
  appState.isAuthenticated = false;
  const gate = document.getElementById('auth-gate-screen');
  if (gate) gate.classList.remove('hidden');
  showToast("تم تسجيل الخروج وقفل المنصة بأمان.");
}

function updateHeaderUserInfo() {
  const nameEl = document.getElementById('header-user-name');
  if (nameEl && appState.currentUser) {
    nameEl.innerText = appState.currentUser.name;
  }
}

// 5. Audio Azan & Tasbeeh Engine
function playAzanSound() {
  try {
    const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    const notes = [261.63, 329.63, 392.00, 523.25];
    notes.forEach((freq, idx) => {
      const osc = audioCtx.createOscillator();
      const gain = audioCtx.createGain();
      osc.type = 'sine';
      osc.frequency.value = freq;
      gain.gain.setValueAtTime(0.15, audioCtx.currentTime + (idx * 0.3));
      gain.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + (idx * 0.3) + 1.2);
      osc.connect(gain);
      gain.connect(audioCtx.destination);
      osc.start(audioCtx.currentTime + (idx * 0.3));
      osc.stop(audioCtx.currentTime + (idx * 0.3) + 1.2);
    });
    showToast("🕌 الله أكبر الله أكبر - حان الآن وقت الأذان بجامع فقيه");
  } catch (e) {
    showToast("🕌 حان الآن وقت الأذان بجامع فقيه بمكة المكرمة");
  }
}

function playTasbeehClick() {
  try {
    const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    const osc = audioCtx.createOscillator();
    const gain = audioCtx.createGain();
    osc.type = 'triangle';
    osc.frequency.setValueAtTime(587.33, audioCtx.currentTime);
    gain.gain.setValueAtTime(0.1, audioCtx.currentTime);
    gain.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 0.08);
    osc.connect(gain);
    gain.connect(audioCtx.destination);
    osc.start();
    osc.stop(audioCtx.currentTime + 0.08);
  } catch (_) {}
}

// Full Adhkar Interactive Engine with Dynamic Schedule & Auto-Advance
function getAdhkarScheduleInfo() {
  const now = new Date();
  const currentMinutes = now.getHours() * 60 + now.getMinutes();

  const prayers = [
    { name: 'الفجر', start: 5 * 60 + 8 },
    { name: 'الظهر', start: 12 * 60 + 28 },
    { name: 'العصر', start: 15 * 60 + 52 },
    { name: 'المغرب', start: 18 * 60 + 33 },
    { name: 'العشاء', start: 20 * 60 + 3 }
  ];

  for (let p of prayers) {
    if (currentMinutes >= p.start && currentMinutes <= p.start + 30) {
      return {
        type: 'post',
        desc: `أذكار بعد صلاة ${p.name} (متاحة لـ 30 دقيقة بعد الصلاة)`
      };
    }
  }

  if (currentMinutes >= 5 * 60 && currentMinutes < 12 * 60) {
    return { type: 'morning', desc: 'أذكار الصباح المباركة (من طلوع الفجر حتى الزوال)' };
  } else if (currentMinutes >= 15 * 60 + 30 && currentMinutes <= 23 * 60 + 59) {
    return { type: 'evening', desc: 'أذكار المساء وحصن المسلم (من العصر حتى نهاية الليل)' };
  } else {
    return { type: 'tasbeeh', desc: 'التسابيح العامة والأذكار المطلقة' };
  }
}

function getActiveAdhkarArray() {
  const schedule = getAdhkarScheduleInfo();
  const cat = appState.adhkarCategory === 'auto' ? schedule.type : appState.adhkarCategory;
  if (cat === 'post') return postPrayerAdhkarData;
  if (cat === 'morning') return morningAdhkarData;
  if (cat === 'evening') return eveningAdhkarData;
  return tasbeehAdhkarData;
}

function switchAdhkarCategory(cat) {
  appState.adhkarCategory = cat;
  appState.adhkarCurrentIndex = 0;
  appState.adhkarCurrentCount = 0;

  document.querySelectorAll('.adhkar-cat-btn').forEach(btn => {
    btn.classList.remove('active', 'btn-primary');
    btn.classList.add('btn-outline');
  });

  const activeBtn = document.getElementById(`adhkar-tab-${cat}`);
  if (activeBtn) {
    activeBtn.classList.remove('btn-outline');
    activeBtn.classList.add('btn-primary', 'active');
  }

  renderAdhkarStepView();
}

function renderAdhkarStepView() {
  const list = getActiveAdhkarArray();
  const schedule = getAdhkarScheduleInfo();
  
  if (appState.adhkarCurrentIndex >= list.length) {
    appState.adhkarCurrentIndex = 0;
  }
  const item = list[appState.adhkarCurrentIndex];

  const timeDescEl = document.getElementById('adhkar-time-desc');
  if (timeDescEl) timeDescEl.innerText = appState.adhkarCategory === 'auto' ? schedule.desc : (
    appState.adhkarCategory === 'post' ? 'أذكار بعد الصلاة المفروضة' :
    appState.adhkarCategory === 'morning' ? 'أذكار الصباح المباركة' :
    appState.adhkarCategory === 'evening' ? 'أذكار المساء وحصن المسلم' : 'التسابيح العامة'
  );

  const progBadge = document.getElementById('adhkar-progress-badge');
  if (progBadge) progBadge.innerText = `الذكر ${appState.adhkarCurrentIndex + 1} من ${list.length}`;

  const sourceBadge = document.getElementById('adhkar-source-badge');
  if (sourceBadge) sourceBadge.innerText = item.source;

  const targetText = document.getElementById('adhkar-target-text');
  if (targetText) targetText.innerText = `المطلوب: ${item.target} ${item.target > 2 ? 'مرات' : 'مرة'}`;

  const currentText = document.getElementById('adhkar-current-text');
  if (currentText) currentText.innerText = item.text;

  const rewardBox = document.getElementById('adhkar-reward-box');
  if (rewardBox) {
    rewardBox.innerText = `⭐ الفضل: ${item.reward}`;
    rewardBox.style.display = item.reward ? 'block' : 'none';
  }

  const btnCount = document.getElementById('adhkar-btn-count');
  if (btnCount) btnCount.innerText = `${appState.adhkarCurrentCount} / ${item.target}`;

  const btnSub = document.getElementById('adhkar-btn-sub');
  if (btnSub) btnSub.innerText = appState.adhkarCurrentCount >= item.target ? 'تم بحمد الله ✓' : 'انقر للعد';

  const counterBtn = document.getElementById('adhkar-counter-btn');
  if (counterBtn) {
    if (appState.adhkarCurrentCount >= item.target) {
      counterBtn.style.background = 'linear-gradient(135deg, #059669 0%, #10b981 100%)';
      counterBtn.style.borderColor = 'var(--success)';
    } else {
      counterBtn.style.background = 'linear-gradient(135deg, #064e3b 0%, #047857 100%)';
      counterBtn.style.borderColor = 'var(--gold)';
    }
  }
}

function handleAdhkarStepClick() {
  const list = getActiveAdhkarArray();
  const item = list[appState.adhkarCurrentIndex];

  if (appState.adhkarCurrentCount < item.target) {
    playTasbeehClick();
    appState.adhkarCurrentCount++;
    renderAdhkarStepView();

    if (appState.adhkarCurrentCount >= item.target) {
      showToast("✓ تم إتمام هذا الذكر المبارك!");
      // Auto-advance to the next sentence
      setTimeout(() => {
        nextAdhkarSentence();
      }, 380);
    }
  }
}

function nextAdhkarSentence() {
  const list = getActiveAdhkarArray();
  if (appState.adhkarCurrentIndex < list.length - 1) {
    appState.adhkarCurrentIndex++;
    appState.adhkarCurrentCount = 0;
    renderAdhkarStepView();
  } else {
    showToast("🎉 هنيئاً لك! أتممت هذا الورد المبارك وتقبل الله طاعتكم.");
  }
}

function prevAdhkarSentence() {
  if (appState.adhkarCurrentIndex > 0) {
    appState.adhkarCurrentIndex--;
    appState.adhkarCurrentCount = 0;
    renderAdhkarStepView();
  }
}

function resetCurrentAdhkarStep() {
  appState.adhkarCurrentCount = 0;
  renderAdhkarStepView();
}

// 6. Toast Notification Engine
function showToast(message) {
  let toast = document.getElementById('app-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'app-toast';
    toast.style.cssText = `
      position: fixed;
      bottom: 24px;
      left: 50%;
      transform: translateX(-50%);
      background: #064e3b;
      color: #ffffff;
      padding: 12px 26px;
      border-radius: 30px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.35);
      border: 1.5px solid #d97706;
      font-weight: 700;
      font-size: 14px;
      z-index: 9999;
      transition: all 0.3s ease;
      text-align: center;
      max-width: 90%;
    `;
    document.body.appendChild(toast);
  }
  toast.innerText = message;
  toast.style.opacity = '1';
  toast.style.bottom = '24px';
  setTimeout(() => {
    toast.style.opacity = '0';
    toast.style.bottom = '-50px';
  }, 3500);
}

// 7. Custom Surah Picker Modal Engine (114 Surahs)
function openSurahPickerFor(target) {
  appState.surahPickerTarget = target;
  renderSurahsList(quranSurahs);
  const modal = document.getElementById('surah-picker-modal');
  if (modal) modal.classList.add('active');
}

function closeSurahPickerModal() {
  const modal = document.getElementById('surah-picker-modal');
  if (modal) modal.classList.remove('active');
}

function renderSurahsList(surahs) {
  const container = document.getElementById('surahs-grid-container');
  if (!container) return;

  container.innerHTML = surahs.map(s => `
    <div class="surah-card-btn" onclick="selectSurah('${s.name}')">
      <div>
        <div style="font-weight: 700; font-size: 14px; color: var(--primary-emerald);">سورة ${s.name}</div>
        <div style="font-size: 11px; color: var(--slate);">${s.verses} آية • جزء ${s.juz}</div>
      </div>
      <div class="surah-number-badge">${s.num}</div>
    </div>
  `).join('');
}

function filterSurahsList(query) {
  const cleanQ = query.trim().toLowerCase();
  if (!cleanQ) {
    renderSurahsList(quranSurahs);
    return;
  }
  const filtered = quranSurahs.filter(s => 
    s.name.includes(cleanQ) || String(s.num) === cleanQ
  );
  renderSurahsList(filtered);
}

function selectSurah(surahName) {
  if (appState.surahPickerTarget === 'new') {
    const hiddenInput = document.getElementById('hw-new-surah');
    const labelSpan = document.getElementById('hw-new-surah-label');
    if (hiddenInput) hiddenInput.value = surahName;
    if (labelSpan) labelSpan.innerText = surahName;
  } else {
    const hiddenInput = document.getElementById('hw-rev-surah');
    const labelSpan = document.getElementById('hw-rev-surah-label');
    if (hiddenInput) hiddenInput.value = surahName;
    if (labelSpan) labelSpan.innerText = surahName;
  }
  closeSurahPickerModal();
}

// 8. Custom Tahfeez Registration Level Stepper & Chips
function changeRegAjzaa(delta) {
  appState.memorizedAjzaaCount = Math.max(0, Math.min(30, appState.memorizedAjzaaCount + delta));
  updateRegLevelUI();
}

function setRegAjzaa(count) {
  appState.memorizedAjzaaCount = count;
  updateRegLevelUI();
}

function updateRegLevelUI() {
  const count = appState.memorizedAjzaaCount;
  appState.selectedRegLevel = count === 0 ? "مبتدئ (تأسيس وتلقين)" : (count === 30 ? "خاتم للقرآن الكريم (30 جزءاً)" : `${count} أجزاء من القرآن`);
  
  const displayEl = document.getElementById('reg-ajzaa-display');
  if (displayEl) displayEl.innerText = count;

  const titleBadge = document.getElementById('reg-level-title-badge');
  if (titleBadge) titleBadge.innerText = appState.selectedRegLevel;

  document.querySelectorAll('.quick-ajzaa-chip').forEach(c => {
    c.classList.toggle('selected', parseInt(c.dataset.preset, 10) === count);
  });
}

// 9. Tahfeez Module Dynamic Rendering
function renderTahfeezModule() {
  const container = document.getElementById('tahfeez-dynamic-content');
  if (!container) return;

  const role = appState.currentRole;

  if (role === 'standard_user' || role === 'mosque_sheikh') {
    const userApp = appState.applications.find(a => a.applicantId === appState.currentUser.id) || appState.applications[0];
    
    let statusText = 'غير مقدم';
    let statusColor = 'var(--gold-dark)';
    if (userApp) {
      if (userApp.status === 'pending') {
        statusText = 'طلبك قيد المراجعة والفرز من المشرف';
        statusColor = 'var(--gold-dark)';
      } else if (userApp.status === 'approved') {
        statusText = 'تم القبول بنجاح ✓';
        statusColor = 'var(--success)';
      } else if (userApp.status === 'rejected') {
        statusText = 'نعتذر لعدم التوفر حالياً (المقاعد مكتملة)';
        statusColor = 'var(--error)';
      }
    }

    container.innerHTML = `
      <div class="glass-card" style="margin-bottom: 20px; border-color: rgba(6, 78, 59, 0.3); background: rgba(240, 253, 244, 0.85);">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px;">
          <h3 style="color: var(--primary-emerald); font-size: 18px;">📋 حالة طلب التحاقك بحلقات الجامع</h3>
          <span class="role-badge" style="background: rgba(6, 78, 59, 0.1); color: ${statusColor}; font-weight: 800;">
            ${statusText}
          </span>
        </div>
        <p style="margin-top: 8px; font-size: 14px; color: var(--slate-dark);">
          ${userApp && userApp.status === 'approved' 
            ? `مرحباً بك ${userApp.applicantName}، تم قبولك وتعيينك في: <strong>${userApp.circleName}</strong>.`
            : (userApp && userApp.status === 'rejected'
              ? `نعتذر منك ${userApp.applicantName}، المقاعد مكتملة حالياً وسنتواصل معك فور توفر حلقة تناسب مستواك.`
              : 'يمكنك التقديم عبر الاستمارة أدناه وسيتم تعيين الحلقة المناسبة لك من قبل المشرف بناءً على مستواك.')}
        </p>
      </div>

      <div class="glass-card">
        <h3 style="font-size: 18px; margin-bottom: 8px; color: var(--primary-emerald);">استمارة طلب التقديم للحلقات القرآنية</h3>
        <p style="font-size: 13px; color: var(--slate); margin-bottom: 20px;">
          ملاحظة: يتم فرز الطلبات وتوزيع الطلاب على الحلقات المعتمدة بمعرفة فضيلة المشرفين وفق معايير الحفظ والتجويد.
        </p>

        <form onsubmit="handleApplicationSubmit(event)">
          <div class="grid-2">
            <div class="form-group">
              <label>الاسم الثلاثي</label>
              <input type="text" class="form-control" id="app-name" value="${appState.currentUser.name}" required>
            </div>
            <div class="form-group">
              <label>رقم الجوال (للتواصل عبر واتساب)</label>
              <input type="tel" class="form-control" id="app-phone" value="${appState.currentUser.phone}" required>
            </div>
          </div>

          <!-- Flexible Ajzaa Selector (0 to 30) -->
          <div class="form-group" style="background: rgba(6,78,59,0.04); padding: 16px; border-radius: 14px; border: 1px solid rgba(6,78,59,0.15);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
              <label style="font-weight: 700; margin: 0;">مستوى الحفظ الحالي (عدد الأجزاء):</label>
              <span class="role-badge role-badge-student" id="reg-level-title-badge">${appState.selectedRegLevel}</span>
            </div>

            <!-- Stepper -->
            <div style="display: flex; align-items: center; justify-content: center; gap: 16px; margin-bottom: 14px;">
              <button type="button" class="btn btn-outline" style="width: 44px; height: 44px; padding: 0; border-radius: 50%; font-size: 20px;" onclick="changeRegAjzaa(-1)">-</button>
              <div style="font-size: 32px; font-weight: 900; color: var(--primary-emerald); min-width: 50px; text-align: center;" id="reg-ajzaa-display">${appState.memorizedAjzaaCount}</div>
              <span style="font-size: 13px; color: var(--slate);">جزءاً</span>
              <button type="button" class="btn btn-primary" style="width: 44px; height: 44px; padding: 0; border-radius: 50%; font-size: 20px;" onclick="changeRegAjzaa(1)">+</button>
            </div>

            <!-- Quick Presets -->
            <div style="font-size: 11px; color: var(--slate); margin-bottom: 6px;">اختيار سريع:</div>
            <div style="display: flex; flex-wrap: wrap; gap: 6px;">
              ${[0, 1, 3, 5, 7, 10, 15, 17, 20, 25, 30].map(p => `
                <button type="button" class="quick-ajzaa-chip btn ${p === appState.memorizedAjzaaCount ? 'btn-primary' : 'btn-outline'}" data-preset="${p}" style="padding: 4px 10px; font-size: 11px;" onclick="setRegAjzaa(${p})">
                  ${p === 0 ? 'تأسيس' : (p === 30 ? 'خاتم (30)' : `${p} أجزاء`)}
                </button>
              `).join('')}
            </div>
          </div>

          <div class="form-group">
            <label>ملاحظات إضافية (أوقات التفرغ أو المشايخ المجاز عندهم)</label>
            <textarea class="form-control" id="app-notes" rows="2" placeholder="أوقات التفرغ المفضلة، المسجد السابق، أو أي رغبات خاصة..."></textarea>
          </div>

          <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px;">
            <i class="fa-solid fa-paper-plane"></i> إرسال طلب الانضمام للمقرأة
          </button>
        </form>
      </div>
    `;
  } else if (role === 'student') {
    const studentData = appState.students[0];
    if (!studentData) {
      container.innerHTML = `
        <div class="glass-card" style="text-align: center; padding: 40px 20px;">
          <i class="fa-solid fa-book-open-reader" style="font-size: 40px; color: var(--primary-emerald); margin-bottom: 14px;"></i>
          <h3 style="color: var(--primary-emerald); font-size: 18px; margin-bottom: 6px;">لا يوجد واجب مسند لك حالياً</h3>
          <p style="color: var(--slate); font-size: 13px;">بانتظار إسناد ورد الحفظ اليومي والمراجعة من قِبل معلم الحلقة.</p>
        </div>
      `;
      return;
    }

    const isExpired = studentData.assignedAt && (Date.now() - studentData.assignedAt > 24 * 3600 * 1000);
    if (isExpired) {
      container.innerHTML = `
        <div class="glass-card" style="margin-bottom: 20px; border-color: rgba(6, 78, 59, 0.3); background: rgba(240, 253, 244, 0.75);">
          <div style="display: flex; justify-content: space-between; align-items: center;">
            <h3 style="color: var(--primary-emerald); font-size: 20px;">${studentData.circleName}</h3>
            <span class="role-badge role-badge-student">تقييم الحفظ: ممتاز ★★★★★</span>
          </div>
        </div>

        <div class="glass-card" style="text-align: center; padding: 40px 20px;">
          <i class="fa-solid fa-hourglass-end" style="font-size: 42px; color: var(--gold-dark); margin-bottom: 14px;"></i>
          <h3 style="color: var(--primary-emerald); font-size: 20px; margin-bottom: 8px;">لا يوجد واجب نشط حالياً</h3>
          <p style="color: var(--slate); font-size: 14px; max-width: 480px; margin: 0 auto;">
            يختفي الواجب تلقائياً بعد مرور 24 ساعة من إسناده، وفي انتظار تعيين المعلم لورد اليوم الجديد.
          </p>
        </div>
      `;
      return;
    }

    container.innerHTML = `
      <div class="glass-card" style="margin-bottom: 20px; border-color: rgba(6, 78, 59, 0.3); background: rgba(240, 253, 244, 0.75);">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
          <div>
            <h3 style="color: var(--primary-emerald); font-size: 20px;">${studentData.circleName}</h3>
            <p style="font-size: 13px; color: var(--slate); margin-top: 2px;">المعلم المشرف: ${studentData.teacher || 'مشرف الحلقة'}</p>
          </div>
          <span class="role-badge role-badge-student">تقييم الحفظ: ممتاز ★★★★★</span>
        </div>
      </div>

      <div class="grid-2">
        <div class="glass-card" style="border: 1.5px solid var(--primary-emerald);">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <span style="background: var(--primary-emerald); color: #fff; padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 700;">الجديد (الحفظ اليومي)</span>
            <span style="color: ${studentData.isCompleted ? 'var(--success)' : 'var(--gold)'}; font-weight: 700; font-size: 13px;">
              ${studentData.isCompleted ? '✓ تم التسميع' : '⏳ قيد التحضير'}
            </span>
          </div>
          <h2 style="font-size: 26px; color: var(--primary-emerald); margin-bottom: 6px;">سورة ${studentData.newSurah}</h2>
          <p style="font-size: 16px; font-weight: 600; color: var(--slate-dark);">من الآية ${studentData.newFrom} إلى الآية ${studentData.newTo}</p>
        </div>

        <div class="glass-card" style="border: 1.5px solid var(--gold);">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <span style="background: var(--gold); color: #fff; padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 700;">المراجعة (التثبيت)</span>
            <span style="color: ${studentData.isCompleted ? 'var(--success)' : 'var(--gold-dark)'}; font-weight: 700; font-size: 13px;">
              ${studentData.isCompleted ? '✓ تم التسميع' : '📖 قيد المراجعة'}
            </span>
          </div>
          <h2 style="font-size: 26px; color: var(--gold-dark); margin-bottom: 6px;">سورة ${studentData.revSurah}</h2>
          <p style="font-size: 16px; font-weight: 600; color: var(--slate-dark);">من الآية ${studentData.revFrom} إلى الآية ${studentData.revTo}</p>
        </div>
      </div>

      <div class="glass-card" style="margin-top: 16px;">
        <p style="font-size: 14px; color: var(--slate-dark); margin-bottom: 14px;">
          💡 <strong>توجيه الشيخ:</strong> ${studentData.notes || 'الالتزام بأحكام التجويد ومخارج الحروف.'}
        </p>
        <button class="btn ${studentData.isCompleted ? 'btn-outline' : 'btn-gold'}" style="width: 100%; padding: 12px;" onclick="toggleStudentHomework()">
          ${studentData.isCompleted ? 'إلغاء علامة الإتمام' : '✓ تأكيد الجاهزية وإتمام التسميع للشيخ'}
        </button>
      </div>
    `;
  } else if (role === 'quran_teacher' || role === 'founder_admin') {
    const pendingCount = appState.applications.filter(a => a.status === 'pending').length;

    container.innerHTML = `
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
        <div>
          <h3 style="font-size: 22px; color: var(--primary-emerald);">لوحة متابعة حلقات التحفيظ (إدارة المقرأة)</h3>
          <p style="font-size: 13px; color: var(--slate);">إشراف إدارة التحفيظ • عدد الطلاب النشطين: ${appState.students.length}</p>
        </div>
        ${appState.students.length > 0 ? `
          <button class="btn btn-primary" onclick="openHomeworkModal('${appState.students[0]?.name || 'الطالب'}')">
            <i class="fa-solid fa-plus"></i> تعيين واجب يومي للطالب
          </button>
        ` : ''}
      </div>

      ${pendingCount > 0 ? `
        <div class="glass-card" style="margin-bottom: 20px; background: rgba(254, 243, 199, 0.85); border-color: var(--gold);">
          <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
            <div style="display: align-items: center; gap: 12px; display: flex;">
              <span style="font-size: 24px;">📬</span>
              <div>
                <h4 style="color: var(--gold-dark); font-size: 16px;">يوجد ${pendingCount} طلبات تسجيل جديدة بالحلقات</h4>
                <p style="font-size: 12px; color: var(--slate-dark);">يمكنك مراجعة مستويات المتقدمين وقبولهم وتعيين الحلقة المناسبة لهم.</p>
              </div>
            </div>
            <button class="btn btn-gold" style="padding: 6px 14px; font-size: 12px;" onclick="openApplicationsModal()">
              مراجعة وتوزيع الطلبات
            </button>
          </div>
        </div>
      ` : ''}

      <div class="glass-card">
        <h4 style="font-size: 16px; margin-bottom: 14px; color: var(--primary-emerald);">قائمة طلاب الحلقة وتسميع اليوم:</h4>
        ${appState.students.length === 0 ? `
          <div style="text-align: center; padding: 24px; color: var(--slate);">
            <i class="fa-solid fa-users" style="font-size: 32px; color: var(--gold-dark); margin-bottom: 10px; display: block;"></i>
            لا يوجد طلاب مسجلين في الحلقة حالياً. يمكنك مراجعة وقبول المتقدمين الجدد من قسم الطلبات أعلاه.
          </div>
        ` : `
          <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; text-align: right; font-size: 14px; min-width: 600px;">
              <thead>
                <tr style="border-bottom: 2px solid var(--border-light); color: var(--slate);">
                  <th style="padding: 10px;">الطالب</th>
                  <th style="padding: 10px;">الحلقة</th>
                  <th style="padding: 10px;">الجديد</th>
                  <th style="padding: 10px;">المراجعة</th>
                  <th style="padding: 10px;">الحالة</th>
                  <th style="padding: 10px;">الإجراء</th>
                </tr>
              </thead>
              <tbody>
                ${appState.students.map(st => `
                  <tr style="border-bottom: 1px solid var(--border-light);">
                    <td style="padding: 12px;"><strong>${st.name}</strong><br><span style="font-size: 11px; color: var(--slate);">${st.level}</span></td>
                    <td style="padding: 12px; font-size: 12px; color: var(--slate-dark);">${st.circleName}</td>
                    <td style="padding: 12px;">${st.newSurah} (${st.newFrom} - ${st.newTo})</td>
                    <td style="padding: 12px;">${st.revSurah} (${st.revFrom} - ${st.revTo})</td>
                    <td style="padding: 12px;">
                      <span class="role-badge role-badge-student">${st.isCompleted ? 'تم التسميع' : 'قيد التسميع'}</span>
                    </td>
                    <td style="padding: 12px;">
                      <button class="btn btn-outline" style="padding: 6px 12px; font-size: 12px;" onclick="openHomeworkModal('${st.name}')">
                        تعديل الواجب
                      </button>
                    </td>
                  </tr>
                `).join('')}
              </tbody>
            </table>
          </div>
        `}
      </div>
    `;
  }
}

// 10. Application Form Submission Handler
function handleApplicationSubmit(event) {
  event.preventDefault();
  const name = document.getElementById('app-name').value.trim();
  const phone = document.getElementById('app-phone').value.trim();
  const notes = document.getElementById('app-notes').value.trim();

  const newApp = {
    id: `app_${Date.now()}`,
    applicantId: appState.currentUser.id,
    applicantName: name,
    phone: phone,
    age: 21,
    level: appState.selectedRegLevel,
    circleName: 'لم تُحدد بعد (يحددها المشرف)',
    status: 'pending',
    date: 'الآن',
    notes: notes
  };

  appState.applications.unshift(newApp);
  renderTahfeezModule();
  showToast("تم إرسال طلبك بنجاح! سيتم فرزه وتعيين الحلقة المناسبة لمستواك.");
}

// 11. Application Review & Seamless Transition to Circle Assignment
function openApplicationsModal() {
  const modal = document.getElementById('applications-modal');
  const container = document.getElementById('applications-list-modal');
  if (container) {
    container.innerHTML = appState.applications.map(a => `
      <div class="glass-card" style="margin-bottom: 12px; padding: 14px;">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 6px;">
          <strong>${a.applicantName}</strong>
          <span class="role-badge ${a.status === 'approved' ? 'role-badge-student' : (a.status === 'rejected' ? 'role-badge-founder' : 'role-badge-sheikh')}">
            ${a.status === 'pending' ? 'قيد المراجعة' : (a.status === 'approved' ? 'تم القبول' : 'نعتذر لعدم التوفر')}
          </span>
        </div>
        <div style="font-size: 12px; color: var(--slate); margin-top: 6px;">
          ${a.phone} • المستوى: <strong>${a.level}</strong>
        </div>
        ${a.notes ? `<div style="font-size: 11px; color: var(--slate-dark); margin-top: 4px;">ملاحظة: ${a.notes}</div>` : ''}
        ${a.status === 'pending' ? `
          <div style="margin-top: 10px; display: flex; gap: 8px;">
            <button class="btn btn-primary" style="padding: 6px 14px; font-size: 12px;" onclick="promptApproveWithCircle('${a.id}')">
              <i class="fa-solid fa-check"></i> قبول وتعيين الحلقة
            </button>
            <button class="btn btn-danger" style="padding: 6px 14px; font-size: 12px;" onclick="rejectApplication('${a.id}')">
              <i class="fa-solid fa-xmark"></i> رفض (نعتذر لعدم التوفر)
            </button>
          </div>
        ` : ''}
      </div>
    `).join('');
  }
  if (modal) modal.classList.add('active');
}

function closeApplicationsModal() {
  const modal = document.getElementById('applications-modal');
  if (modal) modal.classList.remove('active');
}

function rejectApplication(appId) {
  const app = appState.applications.find(a => a.id === appId);
  if (app) {
    app.status = 'rejected';
    openApplicationsModal();
    renderTahfeezModule();
    showToast(`تم رفض طلب ${app.applicantName} وتحديث الحالة إلى نعتذر لعدم التوفر.`);
  }
}

/**
 * Prompt Circle Assignment Modal
 * Requirement: When clicking 'قبول', close the review modal immediately, and open the circle selection modal!
 */
function promptApproveWithCircle(appId) {
  const app = appState.applications.find(a => a.id === appId);
  if (!app) return;

  // 1. Immediately close the review list modal
  closeApplicationsModal();

  // 2. Prepare the circle assignment modal
  const targetInput = document.getElementById('assign-target-app-id');
  const promptEl = document.getElementById('assign-circle-prompt');
  const container = document.getElementById('circle-options-container');

  if (targetInput) targetInput.value = appId;
  if (promptEl) promptEl.innerText = `اختر الحلقة المعتمدة للطالب (${app.applicantName}) بمستوى: ${app.level}`;

  if (container) {
    container.innerHTML = mosqueCircles.map((c, idx) => `
      <div class="level-card-option ${idx === 0 ? 'selected' : ''}" data-circle-id="${c.id}" onclick="selectCircleCardOption(this, '${c.id}')">
        <div>
          <strong>${c.name}</strong>
          <div style="font-size: 11px; color: var(--slate);">${c.teacher} • ${c.schedule}</div>
        </div>
        <i class="fa-solid fa-circle-check"></i>
      </div>
    `).join('');
  }

  // 3. Open the circle assignment modal
  const modal = document.getElementById('assign-circle-modal');
  if (modal) modal.classList.add('active');
}

function selectCircleCardOption(el, circleId) {
  document.querySelectorAll('#circle-options-container .level-card-option').forEach(c => c.classList.remove('selected'));
  el.classList.add('selected');
}

function closeAssignCircleModal() {
  const modal = document.getElementById('assign-circle-modal');
  if (modal) modal.classList.remove('active');
}

function confirmApproveWithCircle(event) {
  event.preventDefault();
  const appId = document.getElementById('assign-target-app-id').value;
  const selectedOption = document.querySelector('#circle-options-container .level-card-option.selected');
  const circleId = selectedOption ? selectedOption.dataset.circleId : 'circle_1';
  const circle = mosqueCircles.find(c => c.id === circleId) || mosqueCircles[0];

  const app = appState.applications.find(a => a.id === appId);
  if (app) {
    app.status = 'approved';
    app.circleName = circle.name;

    // Immediately insert student into active students list
    const existingStudent = appState.students.find(s => s.id === app.applicantId);
    if (!existingStudent) {
      appState.students.unshift({
        id: app.applicantId,
        name: app.applicantName,
        circleId: circle.id,
        circleName: circle.name,
        level: app.level,
        newSurah: 'الفاتحة',
        newFrom: 1,
        newTo: 7,
        revSurah: 'الناس',
        revFrom: 1,
        revTo: 6,
        isCompleted: false,
        notes: 'مرحباً بك في الحلقة، نبدأ بمراجعة سورة الفاتحة وأحكام التلاوة.'
      });
    }

    closeAssignCircleModal();
    renderTahfeezModule();
    showToast(`تم قبول ${app.applicantName} وإدراجه رسمياً في ${circle.name}.`);
  }
}

// 12. Homework Modal Handlers
function openHomeworkModal(studentName = 'طالب الحلقة') {
  const modal = document.getElementById('homework-modal');
  const studentEl = document.getElementById('modal-student-name');
  if (studentEl) studentEl.innerText = studentName;
  if (modal) modal.classList.add('active');
}

function closeHomeworkModal() {
  const modal = document.getElementById('homework-modal');
  if (modal) modal.classList.remove('active');
}

function saveHomework(event) {
  event.preventDefault();
  const newSurah = document.getElementById('hw-new-surah').value;
  const newFrom = parseInt(document.getElementById('hw-new-from').value, 10);
  const newTo = parseInt(document.getElementById('hw-new-to').value, 10);
  const revSurah = document.getElementById('hw-rev-surah').value;
  const revFrom = parseInt(document.getElementById('hw-rev-from').value, 10);
  const revTo = parseInt(document.getElementById('hw-rev-to').value, 10);

  if (appState.students.length > 0) {
    appState.students[0].newSurah = newSurah;
    appState.students[0].newFrom = newFrom;
    appState.students[0].newTo = newTo;
    appState.students[0].revSurah = revSurah;
    appState.students[0].revFrom = revFrom;
    appState.students[0].revTo = revTo;
    appState.students[0].isCompleted = false;
  }

  closeHomeworkModal();
  renderTahfeezModule();
  showToast("تم إسناد واجب الجديد والمراجعة للطالب بنجاح.");
}

function toggleStudentHomework() {
  if (appState.students.length > 0) {
    appState.students[0].isCompleted = !appState.students[0].isCompleted;
    renderTahfeezModule();
    if (appState.students[0].isCompleted) {
      showToast("بارك الله فيك! تم تأكيد إتمام التسميع للشيخ.");
    }
  }
}

// 13. Lessons & Sermons CRUD Management (1 GB Support)
function renderLessonsList() {
  const container = document.getElementById('lessons-list-container');
  const addBtn = document.getElementById('btn-add-lesson');
  if (!container) return;

  const isStaff = appState.currentRole === 'founder_admin' || appState.currentRole === 'mosque_sheikh';
  if (addBtn) addBtn.style.display = isStaff ? 'inline-flex' : 'none';

  container.innerHTML = appState.lessons.map(l => `
    <div class="glass-card">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
        <span class="role-badge role-badge-sheikh">${l.category}</span>
        ${isStaff ? `
          <button class="btn btn-danger" style="padding: 4px 10px; font-size: 11px;" onclick="deleteLesson('${l.id}')">
            <i class="fa-solid fa-trash-can"></i> حذف
          </button>
        ` : ''}
      </div>

      <h3 style="font-size: 17px; color: var(--primary-emerald); margin-bottom: 6px;">${l.title}</h3>
      <p style="font-size: 13px; color: var(--slate); margin-bottom: 2px;">
        <i class="fa-solid fa-user-tie" style="color: var(--gold-dark);"></i> ${l.speaker} • ${l.hall}
      </p>
      <p style="font-size: 11px; color: var(--slate); margin-bottom: 10px;">
        <i class="fa-solid fa-calendar-day"></i> ${l.date} • <i class="fa-solid fa-hard-drive"></i> ${l.fileSize}
      </p>

      <p style="font-size: 13px; color: var(--slate-dark); margin-bottom: 14px; line-height: 1.6;">
        ${l.description}
      </p>

      <button class="btn btn-primary" style="width: 100%; padding: 8px; font-size: 13px;" onclick="showToast('جاري تشغيل التسجيل الصوتي بجودة عالية 🎙️')">
        <i class="fa-solid fa-circle-play"></i> استماع للتسجيل
      </button>
    </div>
  `).join('');
}

function openAddLessonModal() {
  const modal = document.getElementById('add-lesson-modal');
  if (modal) modal.classList.add('active');
}

function closeAddLessonModal() {
  const modal = document.getElementById('add-lesson-modal');
  if (modal) modal.classList.remove('active');
}

function validateMediaFileSize(fileInput) {
  const statusEl = document.getElementById('lesson-file-status');
  if (!fileInput.files || !fileInput.files[0]) return;

  const file = fileInput.files[0];
  const sizeMB = file.size / (1024 * 1024);

  if (sizeMB > 1024) {
    if (statusEl) {
      statusEl.innerHTML = `<span style="color: var(--error); font-weight: 700;">⚠️ خطأ: حجم الملف (${sizeMB.toFixed(1)} MB) يتجاوز الحد الأقصى المسموح به (1024 MB / 1 GB).</span>`;
    }
    fileInput.value = '';
    showToast("⚠️ لا يمكن رفع ملف يتجاوز 1 جيجابايت.");
  } else {
    if (statusEl) {
      statusEl.innerHTML = `<span style="color: var(--success); font-weight: 700;">✓ حجم الملف مقبول (${sizeMB.toFixed(1)} MB من أصل 1024 MB المتاحة).</span>`;
    }
  }
}

function handleSaveNewLesson(event) {
  event.preventDefault();
  const title = document.getElementById('lesson-title-input').value.trim();
  const speaker = document.getElementById('lesson-speaker-input').value.trim();
  const category = document.getElementById('lesson-category-input').value;
  const desc = document.getElementById('lesson-desc-input').value.trim();

  const newLesson = {
    id: `les_${Date.now()}`,
    title: title,
    speaker: speaker,
    category: category,
    hall: 'المصلى الرئيسي - جامع فقيه',
    description: desc,
    fileSize: '185 ميجابايت',
    date: 'الآن',
    audioUrl: 'https://example.com/audio/new_khutbah.mp3'
  };

  appState.lessons.unshift(newLesson);
  closeAddLessonModal();
  renderLessonsList();
  showToast("تم رفع ونشر الخطبة / الدرس الجديد بنجاح (معتمد حتى 1GB).");
}

function deleteLesson(lessonId) {
  if (confirm("هل أنت متأكد من رغبتك في حذف هذه الخطبة نهائياً من الجامع؟")) {
    appState.lessons = appState.lessons.filter(l => l.id !== lessonId);
    renderLessonsList();
    showToast("تم حذف الخطبة بنجاح.");
  }
}

// 14. Prayer Times & Override Handlers
function renderPrayerTimesList() {
  const container = document.getElementById('prayer-times-grid');
  if (!container) return;

  container.innerHTML = appState.prayers.map(p => `
    <div class="glass-card" style="display: flex; justify-content: space-between; align-items: center; padding: 16px 20px;">
      <div>
        <div style="font-size: 18px; font-weight: 700; color: var(--primary-emerald);">${p.nameAr}</div>
        ${p.key !== 'sunrise' ? `<div style="font-size: 12px; color: var(--slate);">الإقامة بعد ${p.iqama} دقيقة</div>` : ''}
      </div>
      <div style="text-align: left;">
        <div style="font-size: 22px; font-weight: 800;">${p.time}</div>
        ${p.isOverridden ? '<span style="font-size: 10px; color: var(--gold-dark); font-weight: 700;">★ معتمد من الشيخ</span>' : ''}
      </div>
    </div>
  `).join('');
}

function openPrayerOverrideModal() {
  const modal = document.getElementById('prayer-override-modal');
  if (modal) modal.classList.add('active');
}

function closePrayerOverrideModal() {
  const modal = document.getElementById('prayer-override-modal');
  if (modal) modal.classList.remove('active');
}

function savePrayerOverride(event) {
  event.preventDefault();
  const prayerKey = document.getElementById('override-prayer-select').value;
  const newTime = document.getElementById('override-time-input').value;
  const newIqama = document.getElementById('override-iqama-input').value;

  const prayer = appState.prayers.find(p => p.key === prayerKey);
  if (prayer) {
    prayer.time = newTime;
    prayer.iqama = parseInt(newIqama, 10);
    prayer.isOverridden = true;
  }

  closePrayerOverrideModal();
  renderPrayerTimesList();
  showToast(`تم حفظ وتحديث وقت ${prayer.nameAr} وإقامتها بنجاح.`);
}

function getNextPrayerInfo() {
  const now = new Date();
  
  // Prayer schedule for Makkah Al-Mukarramah
  const schedule = [
    { key: 'fajr', name: 'الفجر', h: 5, m: 8, timeStr: '05:08 ص', iqama: 25 },
    { key: 'dhuhr', name: 'الظهر', h: 12, m: 28, timeStr: '12:28 م', iqama: 20 },
    { key: 'asr', name: 'العصر', h: 15, m: 52, timeStr: '03:52 م', iqama: 20 },
    { key: 'maghrib', name: 'المغرب', h: 18, m: 33, timeStr: '06:33 م', iqama: 10 },
    { key: 'isha', name: 'العشاء', h: 20, m: 3, timeStr: '08:03 م', iqama: 20 }
  ];

  for (const p of schedule) {
    const pDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), p.h, p.m, 0, 0);
    if (pDate > now) {
      return { prayer: p, targetDate: pDate };
    }
  }

  // Next is tomorrow's Fajr
  const tomorrowFajr = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 5, 8, 0, 0);
  return { prayer: schedule[0], targetDate: tomorrowFajr };
}

function updateCountdown() {
  const { prayer, targetDate } = getNextPrayerInfo();
  const now = new Date();
  let diff = targetDate.getTime() - now.getTime();
  if (diff < 0) diff = 0;

  const hours = Math.floor(diff / (1000 * 60 * 60));
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((diff % (1000 * 60)) / 1000);

  const pad = (n) => String(n).padStart(2, '0');
  
  const nameEl = document.getElementById('hero-prayer-name');
  const timeEl = document.getElementById('hero-prayer-time');
  const iqamaEl = document.getElementById('hero-prayer-iqama');
  const digitsEl = document.getElementById('prayer-countdown-digits');

  if (nameEl) nameEl.innerText = `صلاة ${prayer.name}`;
  if (timeEl) timeEl.innerText = prayer.timeStr;
  if (iqamaEl) iqamaEl.innerText = `الإقامة بعد ${prayer.iqama} دقائق`;
  if (digitsEl) {
    digitsEl.innerText = `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
  }
}

// 15. Profile Privacy & Strict Role Visibility
function renderProfileModule() {
  const container = document.getElementById('profile-dynamic-content');
  if (!container) return;

  const user = appState.currentUser || appState.users[4];
  const role = user.role;

  // Enforce Privacy Rule: DO NOT display "شخص عادي" or "مصلي" anywhere!
  let roleBadgeHtml = '';
  if (role === 'founder_admin') {
    roleBadgeHtml = '<span class="role-badge role-badge-founder">👑 مؤسس التطبيق / مدير النظام</span>';
  } else if (role === 'mosque_sheikh') {
    roleBadgeHtml = '<span class="role-badge role-badge-sheikh">🕌 فضيلة شيخ المسجد</span>';
  } else if (role === 'quran_teacher') {
    roleBadgeHtml = '<span class="role-badge role-badge-teacher">📖 معلم التحفيظ</span>';
  } else if (role === 'student') {
    roleBadgeHtml = '<span class="role-badge role-badge-student">🎓 طالب بالحلقة</span>';
  }

  container.innerHTML = `
    <div class="glass-card" style="text-align: center; max-width: 560px; margin: 0 auto;">
      <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(6, 78, 59, 0.15); color: var(--primary-emerald); font-size: 36px; font-weight: 800; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px auto; border: 2px solid var(--gold);">
        ${user.name ? user.name[0] : 'U'}
      </div>
      <h2 style="font-size: 22px; font-weight: 800; margin-bottom: 4px;">${user.name}</h2>
      <p style="font-size: 14px; color: var(--slate); margin-bottom: 12px;">${user.email} • ${user.phone}</p>
      
      ${roleBadgeHtml ? `<div style="margin-bottom: 16px;">${roleBadgeHtml}</div>` : ''}

      <div style="text-align: right; border-top: 1px solid var(--border-light); padding-top: 20px; margin-top: 20px;">
        <h4 style="font-size: 15px; margin-bottom: 14px;">تفضيلات الإشعارات والتنبيهات:</h4>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
          <div>
            <div style="font-weight: 600; font-size: 14px;">تنبيه الأذان بصوت الحرم المكي</div>
            <div style="font-size: 11px; color: var(--slate);">تشغيل الأذان مع دخول الوقت</div>
          </div>
          <input type="checkbox" checked style="width: 20px; height: 20px; accent-color: var(--primary-emerald);">
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
          <div>
            <div style="font-weight: 600; font-size: 14px;">أذكار ما بعد الصلاة التلقائية</div>
            <div style="font-size: 11px; color: var(--slate);">إشعار تلقائي بالأذكار دبر كل فريضة</div>
          </div>
          <input type="checkbox" checked style="width: 20px; height: 20px; accent-color: var(--primary-emerald);">
        </div>

        <button class="btn btn-danger" style="width: 100%;" onclick="logoutToGate()">
          <i class="fa-solid fa-arrow-right-from-bracket"></i> تسجيل الخروج وقفل الحساب
        </button>
      </div>
    </div>
  `;
}

// 16. Admin Controls & User Management
function renderAdminControls() {
  const adminBtn = document.getElementById('btn-admin-override');
  const userMgmtTab = document.getElementById('tab-user-mgmt-btn');
  const role = appState.currentRole;

  if (adminBtn) {
    adminBtn.style.display = (role === 'founder_admin' || role === 'mosque_sheikh') ? 'inline-flex' : 'none';
  }

  if (userMgmtTab) {
    userMgmtTab.style.display = (role === 'founder_admin' || role === 'mosque_sheikh') ? 'inline-flex' : 'none';
  }

  renderUserManagementTable();
}

function renderUserManagementTable() {
  const tbody = document.getElementById('users-table-body');
  if (!tbody) return;

  const isFounder = appState.currentRole === 'founder_admin';

  tbody.innerHTML = appState.users.map(u => {
    let roleText = 'مستخدم عام';
    if (u.role === 'founder_admin') roleText = 'مؤسس التطبيق';
    if (u.role === 'mosque_sheikh') roleText = 'شيخ المسجد';
    if (u.role === 'quran_teacher') roleText = 'معلم التحفيظ';
    if (u.role === 'student') roleText = 'طالب';

    return `
      <tr style="border-bottom: 1px solid var(--border-light);">
        <td style="padding: 12px;"><strong>${u.name}</strong></td>
        <td style="padding: 12px; color: var(--slate);">${u.email}</td>
        <td style="padding: 12px;">${u.phone}</td>
        <td style="padding: 12px;">
          ${isFounder ? `
            <select class="form-control" style="padding: 4px 8px; font-size: 12px;" onchange="changeUserRole('${u.id}', this.value)">
              <option value="founder_admin" ${u.role === 'founder_admin' ? 'selected' : ''}>مؤسس التطبيق</option>
              <option value="mosque_sheikh" ${u.role === 'mosque_sheikh' ? 'selected' : ''}>شيخ المسجد</option>
              <option value="quran_teacher" ${u.role === 'quran_teacher' ? 'selected' : ''}>معلم التحفيظ</option>
              <option value="student" ${u.role === 'student' ? 'selected' : ''}>طالب</option>
              <option value="standard_user" ${u.role === 'standard_user' ? 'selected' : ''}>مستخدم عام</option>
            </select>
          ` : `<span>${roleText}</span>`}
        </td>
      </tr>
    `;
  }).join('');
}

function changeUserRole(userId, newRole) {
  const user = appState.users.find(u => u.id === userId);
  if (user) {
    user.role = newRole;
    showToast(`تم تحديث صلاحية ${user.name} بنجاح.`);
  }
}

// 17. Navigation Tab Switcher
function switchTab(tabId) {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.tab === tabId);
  });
  document.querySelectorAll('.tab-pane').forEach(pane => {
    pane.style.display = (pane.id === `tab-${tabId}`) ? 'block' : 'none';
  });
  if (tabId === 'adhkar') {
    renderAdhkarStepView();
  }
}

// 18. Dark/Light Theme Switcher
function toggleTheme() {
  appState.theme = appState.theme === 'light' ? 'dark' : 'light';
  document.documentElement.setAttribute('data-theme', appState.theme);
}

// Initialization on Window Load
window.addEventListener('DOMContentLoaded', () => {
  initSplashAnimation();
  renderPrayerTimesList();
  renderTahfeezModule();
  renderLessonsList();
  renderProfileModule();
  renderAdminControls();
  renderAdhkarStepView();
  setInterval(updateCountdown, 1000);
  updateCountdown();
});

// 19. PWA Native Installation Engine
let deferredPwaPrompt = null;
window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
  deferredPwaPrompt = e;
  const btn = document.getElementById('btn-install-app');
  if (btn) btn.style.display = 'inline-flex';
});

function triggerPWAInstall() {
  if (deferredPwaPrompt) {
    deferredPwaPrompt.prompt();
    deferredPwaPrompt.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        showToast('تم قبول التثبيت! جاري إضافة تطبيق فقيه إلى شاشة هاتفك.');
      }
      deferredPwaPrompt = null;
    });
  } else {
    // Check if on iOS Safari
    const isIos = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
    if (isIos) {
      alert('لتثبيت تطبيق فقيه على الآيفون:\n1. اضغط على زر المشاركة (Share ⬆️) بالأسفل.\n2. اختر "إضافة إلى الصفحة الرئيسية" (Add to Home Screen ➕).');
    } else {
      showToast('التطبيق مثبت بالفعل أو يمكنك إضافته من خيارات المتصفح (تثبيت التطبيق).');
    }
  }
}

// Register Service Worker for Offline & Installability
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/sw.js').then((reg) => {
      console.log('Fakieh PWA Service Worker Registered:', reg.scope);
    }).catch((err) => {
      console.warn('Service Worker registration failed:', err);
    });
  });
}
