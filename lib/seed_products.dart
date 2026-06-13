/// Run this script ONCE to seed your Firestore with sample products.
///
/// Usage:
///   flutter run -t lib/seed_products.dart
///
/// After it prints "✅ Seeding complete!", stop the app and run your main app normally.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('products');

  // Delete existing documents first
  final existing = await collection.get();
  for (var doc in existing.docs) {
    await doc.reference.delete();
  }
  debugPrint('🗑️ Cleared existing products');

  final products = _getProducts();

  int count = 0;
  for (var product in products) {
    await collection.doc(product['code'] as String).set(product);
    count++;
    if (count % 10 == 0) {
      debugPrint('✅ Added $count/${products.length} products...');
    }
  }

  debugPrint('\n✅ Seeding complete! ${products.length} products added.');
  debugPrint('You can now stop this app and run your main app normally.');
}

List<Map<String, dynamic>> _getProducts() {
  return [
    // ========== APPLES (10) ==========
    _product('تفاح أحمر', 'apple_red_1', 'تفاح أحمر طازج غني بالألياف ومضادات الأكسدة', 15, true, true, 95, 2, 120, 'https://images.unsplash.com/photo-1568702846914-96b305d2uj38?w=400&fit=crop'),
    _product('تفاح أخضر', 'apple_green_1', 'تفاح أخضر مقرمش وحامض قليلاً', 14, true, true, 52, 2, 95, 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?w=400&fit=crop'),
    _product('تفاح ذهبي', 'apple_golden_1', 'تفاح ذهبي حلو ومثالي للسلطات', 16, false, false, 57, 2, 70, 'https://images.unsplash.com/photo-1570913149827-d2ac84ab3f9a?w=400&fit=crop'),
    _product('تفاح فوجي', 'apple_fuji_1', 'تفاح فوجي ياباني حلو وعصيري', 20, false, true, 63, 2, 55, 'https://images.unsplash.com/photo-1584306670957-acf935f5033c?w=400&fit=crop'),
    _product('تفاح بينك ليدي', 'apple_pink_lady', 'تفاح بينك ليدي حلو وحامض بتوازن مثالي', 22, false, false, 50, 2, 40, 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400&fit=crop'),
    _product('تفاح هوني كريسب', 'apple_honeycrisp', 'تفاح هوني كريسب مقرمش وعصيري جداً', 25, true, true, 53, 2, 85, 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400&fit=crop'),
    _product('تفاح جالا', 'apple_gala', 'تفاح جالا حلو خفيف ومناسب للأطفال', 13, false, false, 55, 2, 60, 'https://images.unsplash.com/photo-1576179635662-9d1983e97e1e?w=400&fit=crop'),
    _product('تفاح جراني سميث', 'apple_granny_smith', 'تفاح أخضر حامض مثالي للطبخ', 12, false, true, 48, 2, 45, 'https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?w=400&fit=crop'),
    _product('تفاح ماكنتوش', 'apple_mcintosh', 'تفاح ماكنتوش ناعم وعطري', 18, false, false, 60, 2, 30, 'https://images.unsplash.com/photo-1590005354167-6da97870c757?w=400&fit=crop'),
    _product('تفاح بريبرن', 'apple_braeburn', 'تفاح بريبرن متوسط الحلاوة والحموضة', 17, false, true, 52, 2, 35, 'https://images.unsplash.com/photo-1600423115367-87ea7661688f?w=400&fit=crop'),

    // ========== BANANAS (8) ==========
    _product('موز كافنديش', 'banana_cavendish_1', 'موز كافنديش طازج غني بالبوتاسيوم', 10, true, false, 105, 1, 200, 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&fit=crop'),
    _product('موز أحمر', 'banana_red', 'موز أحمر نادر بطعم كريمي', 25, false, true, 90, 1, 30, 'https://images.unsplash.com/photo-1587132137056-bfbf0166836e?w=400&fit=crop'),
    _product('موز بيبي', 'banana_baby', 'موز صغير حلو ومغذي', 15, false, false, 80, 1, 65, 'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=400&fit=crop'),
    _product('موز عضوي', 'banana_organic', 'موز عضوي خالي من المبيدات', 18, true, true, 105, 1, 150, 'https://images.unsplash.com/photo-1481349518771-20055b2a7b24?w=400&fit=crop'),
    _product('موز بلانتين', 'banana_plantain', 'موز الطبخ الأخضر للقلي', 12, false, false, 122, 1, 40, 'https://images.unsplash.com/photo-1528825871115-3581a5e0791d?w=400&fit=crop'),
    _product('موز مجفف', 'banana_dried', 'رقائق موز مجففة طبيعياً', 30, false, true, 89, 6, 75, 'https://images.unsplash.com/photo-1599639668273-ce295d76dd35?w=400&fit=crop'),
    _product('موز كناري', 'banana_canary', 'موز كناري صغير وحلو', 20, false, false, 95, 1, 25, 'https://images.unsplash.com/photo-1543218024-57a70143c369?w=400&fit=crop'),
    _product('موز ويليامز', 'banana_williams', 'موز ويليامز كبير الحجم', 11, false, false, 110, 1, 90, 'https://images.unsplash.com/photo-1574226516831-e1dff420e562?w=400&fit=crop'),

    // ========== ORANGES (10) ==========
    _product('برتقال نافل', 'orange_navel_1', 'برتقال نافل حلو بدون بذور', 12, true, true, 62, 2, 180, 'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?w=400&fit=crop'),
    _product('برتقال فالنسيا', 'orange_valencia', 'برتقال فالنسيا مثالي للعصير', 10, true, false, 59, 2, 160, 'https://images.unsplash.com/photo-1611080626919-7cf5a9dbab5b?w=400&fit=crop'),
    _product('برتقال دم', 'orange_blood', 'برتقال دم بلون أحمر مميز', 18, false, true, 60, 2, 50, 'https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?w=400&fit=crop'),
    _product('برتقال ماندرين', 'orange_mandarin', 'ماندرين صغير حلو وسهل التقشير', 15, true, false, 53, 1, 130, 'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=400&fit=crop'),
    _product('كلمنتينا', 'orange_clementine', 'كلمنتينا حلوة بدون بذور', 20, false, true, 47, 1, 70, 'https://images.unsplash.com/photo-1597714026720-8f74c62310ba?w=400&fit=crop'),
    _product('يوسفي', 'orange_tangerine', 'يوسفي طازج حلو وعطري', 14, false, false, 53, 1, 95, 'https://images.unsplash.com/photo-1585538399894-4b49ee8f3e33?w=400&fit=crop'),
    _product('برتقال كارا كارا', 'orange_cara_cara', 'برتقال كارا كارا وردي اللون', 22, false, true, 58, 2, 35, 'https://images.unsplash.com/photo-1547514701-42782101795e?w=400&fit=crop'),
    _product('برتقال سيفيل', 'orange_seville', 'برتقال حامض مثالي للمربى', 10, false, false, 40, 2, 20, 'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=400&fit=crop'),
    _product('ليمون', 'lemon_1', 'ليمون طازج غني بفيتامين سي', 8, true, true, 29, 3, 140, 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=400&fit=crop'),
    _product('ليمون أخضر', 'lime_1', 'ليمون أخضر منعش للمشروبات', 10, false, false, 20, 2, 80, 'https://images.unsplash.com/photo-1590004953392-5aba2e72269a?w=400&fit=crop'),

    // ========== BERRIES (12) ==========
    _product('فراولة طازجة', 'strawberry_1', 'فراولة حمراء طازجة وحلوة', 25, true, true, 33, 1, 250, 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=400&fit=crop'),
    _product('فراولة عضوية', 'strawberry_organic', 'فراولة عضوية بحجم كبير', 35, false, true, 33, 1, 80, 'https://images.unsplash.com/photo-1543528176-61b239494933?w=400&fit=crop'),
    _product('توت أزرق', 'blueberry_1', 'توت أزرق غني بمضادات الأكسدة', 40, true, true, 57, 1, 170, 'https://images.unsplash.com/photo-1498557850523-fd3d118b962e?w=400&fit=crop'),
    _product('توت أسود', 'blackberry_1', 'توت أسود حلو وحامض', 35, false, true, 43, 1, 60, 'https://images.unsplash.com/photo-1615484477778-ca3b77940c25?w=400&fit=crop'),
    _product('توت بري', 'cranberry_1', 'توت بري حامض غني بالفيتامينات', 45, false, true, 46, 2, 40, 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&fit=crop'),
    _product('توت العليق', 'raspberry_1', 'توت العليق الأحمر الطازج', 38, true, true, 52, 1, 90, 'https://images.unsplash.com/photo-1577069861033-55d04cec4ef5?w=400&fit=crop'),
    _product('كرز', 'cherry_1', 'كرز أحمر داكن حلو', 30, true, false, 63, 1, 110, 'https://images.unsplash.com/photo-1528821128474-27f963b062bf?w=400&fit=crop'),
    _product('كرز أسود', 'cherry_black', 'كرز أسود حلو وعصيري', 35, false, true, 63, 1, 55, 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=400&fit=crop'),
    _product('عنب أحمر', 'grape_red_1', 'عنب أحمر حلو بدون بذور', 20, true, false, 69, 1, 140, 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=400&fit=crop'),
    _product('عنب أخضر', 'grape_green_1', 'عنب أخضر مقرمش ومنعش', 18, false, false, 67, 1, 120, 'https://images.unsplash.com/photo-1596363505729-4190a9506133?w=400&fit=crop'),
    _product('عنب أسود', 'grape_black_1', 'عنب أسود غني بالحديد', 22, false, true, 70, 1, 85, 'https://images.unsplash.com/photo-1599819177626-b50f9dd21c9b?w=400&fit=crop'),
    _product('عنب بدون بذور', 'grape_seedless', 'عنب أخضر بدون بذور مثالي للأطفال', 24, false, false, 65, 1, 100, 'https://images.unsplash.com/photo-1631159024574-91f14e2e8c4f?w=400&fit=crop'),

    // ========== TROPICAL (15) ==========
    _product('مانجو ألفونسو', 'mango_alphonso', 'مانجو ألفونسو الهندية الفاخرة', 40, true, true, 99, 1, 300, 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=400&fit=crop'),
    _product('مانجو كنت', 'mango_kent', 'مانجو كنت كبيرة الحجم', 35, true, false, 99, 1, 180, 'https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?w=400&fit=crop'),
    _product('مانجو عويسي', 'mango_awees', 'مانجو عويسي مصرية حلوة', 30, false, false, 99, 1, 220, 'https://images.unsplash.com/photo-1591073113125-e46713c829ed?w=400&fit=crop'),
    _product('أناناس', 'pineapple_1', 'أناناس استوائي طازج وحلو', 28, true, false, 82, 2, 130, 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=400&fit=crop'),
    _product('أناناس صغير', 'pineapple_mini', 'أناناس صغير حلو جداً', 20, false, true, 75, 1, 50, 'https://images.unsplash.com/photo-1589820296156-2454bb8a6ad1?w=400&fit=crop'),
    _product('بابايا', 'papaya_1', 'بابايا ناضجة غنية بالإنزيمات', 22, false, true, 43, 1, 45, 'https://images.unsplash.com/photo-1517282009859-f000ec3b26fe?w=400&fit=crop'),
    _product('جوافة', 'guava_1', 'جوافة طازجة غنية بفيتامين سي', 15, true, true, 68, 1, 160, 'https://images.unsplash.com/photo-1536511132770-e5058c7e8c46?w=400&fit=crop'),
    _product('باشن فروت', 'passion_fruit_1', 'فاكهة العاطفة حامضة وعطرية', 30, false, true, 97, 1, 35, 'https://images.unsplash.com/photo-1604495772376-9657f0035eb5?w=400&fit=crop'),
    _product('جوز الهند', 'coconut_1', 'جوز الهند الطازج بماء منعش', 20, false, false, 354, 3, 75, 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=400&fit=crop'),
    _product('ليتشي', 'lychee_1', 'ليتشي حلوة وعصيرية', 35, false, true, 66, 1, 40, 'https://images.unsplash.com/photo-1577003811926-53b099a67c02?w=400&fit=crop'),
    _product('دراجون فروت', 'dragon_fruit_1', 'فاكهة التنين بلون زهري مميز', 30, true, true, 60, 1, 65, 'https://images.unsplash.com/photo-1527325678964-54921661f888?w=400&fit=crop'),
    _product('كيوي', 'kiwi_1', 'كيوي طازج غني بفيتامين سي', 18, true, true, 42, 2, 140, 'https://images.unsplash.com/photo-1585059895524-72f83bab667d?w=400&fit=crop'),
    _product('كيوي ذهبي', 'kiwi_golden', 'كيوي ذهبي حلو بدون حموضة', 25, false, true, 42, 2, 50, 'https://images.unsplash.com/photo-1618897996318-5a901fa6ca71?w=400&fit=crop'),
    _product('ستار فروت', 'star_fruit_1', 'فاكهة النجمة الاستوائية المنعشة', 28, false, true, 31, 1, 20, 'https://images.unsplash.com/photo-1595412029973-f18fb0e8e09d?w=400&fit=crop'),
    _product('رامبوتان', 'rambutan_1', 'رامبوتان حلوة من جنوب شرق آسيا', 40, false, true, 75, 1, 15, 'https://images.unsplash.com/photo-1609241364474-97dc10d0e36e?w=400&fit=crop'),

    // ========== MELONS (8) ==========
    _product('بطيخ أحمر', 'watermelon_1', 'بطيخ أحمر منعش بدون بذور', 25, true, false, 30, 1, 280, 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400&fit=crop'),
    _product('بطيخ أصفر', 'watermelon_yellow', 'بطيخ أصفر نادر وحلو', 30, false, true, 30, 1, 40, 'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=400&fit=crop'),
    _product('شمام', 'cantaloupe_1', 'شمام حلو وعصيري برتقالي', 18, true, false, 34, 1, 150, 'https://images.unsplash.com/photo-1571575173700-afb9492e6a50?w=400&fit=crop'),
    _product('شمام عسلي', 'honeydew_1', 'شمام عسلي أخضر حلو', 20, false, false, 36, 1, 80, 'https://images.unsplash.com/photo-1568584711271-6c929fb49b60?w=400&fit=crop'),
    _product('شمام جاليا', 'melon_galia', 'شمام جاليا معطر وحلو', 22, false, true, 34, 1, 55, 'https://images.unsplash.com/photo-1594995846645-a625bf3aef44?w=400&fit=crop'),
    _product('بطيخ مكعبات', 'watermelon_cubed', 'بطيخ مقطع جاهز للأكل', 15, false, false, 30, 1, 90, 'https://images.unsplash.com/photo-1582281298055-e25b84a30b0b?w=400&fit=crop'),
    _product('شمام كوري', 'melon_korean', 'شمام كوري أصفر مقرمش', 35, false, true, 32, 1, 25, 'https://images.unsplash.com/photo-1609842947419-ba4f04d5d60f?w=400&fit=crop'),
    _product('بطيخ صغير', 'watermelon_mini', 'بطيخ صغير مثالي لشخص واحد', 12, false, false, 30, 1, 110, 'https://images.unsplash.com/photo-1595475207225-428b62bda831?w=400&fit=crop'),

    // ========== STONE FRUITS (10) ==========
    _product('خوخ', 'peach_1', 'خوخ ناعم وحلو طازج', 16, true, false, 59, 1, 130, 'https://images.unsplash.com/photo-1629828874514-cee2d0e51f86?w=400&fit=crop'),
    _product('خوخ أبيض', 'peach_white', 'خوخ أبيض حلو وعطري', 20, false, true, 57, 1, 50, 'https://images.unsplash.com/photo-1595124277807-5a8b4f2e9e10?w=400&fit=crop'),
    _product('نكتارين', 'nectarine_1', 'نكتارين أملس حلو وعصيري', 18, false, false, 63, 1, 70, 'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=400&fit=crop'),
    _product('مشمش', 'apricot_1', 'مشمش طازج غني بفيتامين أ', 20, true, true, 48, 1, 95, 'https://images.unsplash.com/photo-1592681742486-7b3b4e760b01?w=400&fit=crop'),
    _product('برقوق أحمر', 'plum_red', 'برقوق أحمر حلو ولذيذ', 15, false, false, 46, 1, 60, 'https://images.unsplash.com/photo-1602576052615-a3ae7e47faa8?w=400&fit=crop'),
    _product('برقوق أسود', 'plum_black', 'برقوق أسود غني بالألياف', 16, false, true, 46, 1, 45, 'https://images.unsplash.com/photo-1564442038901-4f9a19d3d456?w=400&fit=crop'),
    _product('كمثرى', 'pear_1', 'كمثرى خضراء طازجة ومقرمشة', 14, true, false, 57, 2, 100, 'https://images.unsplash.com/photo-1514756331096-242fdeb70d4a?w=400&fit=crop'),
    _product('كمثرى آسيوية', 'pear_asian', 'كمثرى آسيوية مقرمشة وعصيرية', 22, false, true, 42, 2, 40, 'https://images.unsplash.com/photo-1615484477778-ca3b77940c25?w=400&fit=crop'),
    _product('كمثرى حمراء', 'pear_red', 'كمثرى حمراء حلوة وناعمة', 16, false, false, 57, 2, 65, 'https://images.unsplash.com/photo-1541728472741-03e45a58cf88?w=400&fit=crop'),
    _product('تين', 'fig_1', 'تين طازج حلو وغني بالمعادن', 30, true, true, 74, 1, 80, 'https://images.unsplash.com/photo-1601379760883-1bb497c558e4?w=400&fit=crop'),

    // ========== EXOTIC (10) ==========
    _product('رمان', 'pomegranate_1', 'رمان مليء بالبذور الحمراء', 22, true, true, 83, 3, 150, 'https://images.unsplash.com/photo-1541344999736-83ede5e82024?w=400&fit=crop'),
    _product('رمان هندي', 'pomegranate_indian', 'رمان هندي بحبات كبيرة', 28, false, true, 83, 3, 60, 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&fit=crop'),
    _product('أفوكادو', 'avocado_1', 'أفوكادو ناضج كريمي', 30, true, true, 160, 1, 200, 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400&fit=crop'),
    _product('أفوكادو هاس', 'avocado_hass', 'أفوكادو هاس بقشرة داكنة', 35, false, true, 160, 1, 120, 'https://images.unsplash.com/photo-1519162808019-7de1683fa2ad?w=400&fit=crop'),
    _product('جريب فروت', 'grapefruit_1', 'جريب فروت وردي منعش', 12, false, false, 42, 2, 55, 'https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?w=400&fit=crop'),
    _product('جريب فروت أحمر', 'grapefruit_red', 'جريب فروت أحمر حلو', 15, false, true, 42, 2, 35, 'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?w=400&fit=crop'),
    _product('تمر مجدول', 'dates_medjool', 'تمر مجدول فاخر كبير الحجم', 50, true, true, 277, 12, 180, 'https://images.unsplash.com/photo-1593001874117-c99c800e3eb7?w=400&fit=crop'),
    _product('تمر خلاص', 'dates_khalas', 'تمر خلاص سعودي ذهبي', 45, false, true, 277, 12, 90, 'https://images.unsplash.com/photo-1597371424128-8ffb54f10c1e?w=400&fit=crop'),
    _product('صبار (تين شوكي)', 'prickly_pear', 'تين شوكي حلو ومنعش', 15, false, false, 41, 1, 40, 'https://images.unsplash.com/photo-1596391428498-2a8e3e81b614?w=400&fit=crop'),
    _product('كاكا', 'persimmon_1', 'كاكا ناضجة حلوة كالعسل', 25, false, true, 70, 1, 30, 'https://images.unsplash.com/photo-1604242692760-2f7b0c26856d?w=400&fit=crop'),

    // ========== CITRUS & OTHERS (12) ==========
    _product('جوافة حمراء', 'guava_red', 'جوافة حمراء من الداخل', 18, false, true, 68, 1, 85, 'https://images.unsplash.com/photo-1603048719539-9ecb4aa395e3?w=400&fit=crop'),
    _product('سفرجل', 'quince_1', 'سفرجل عطري مثالي للمربى', 15, false, false, 57, 2, 20, 'https://images.unsplash.com/photo-1568702846914-96b305d2uj38?w=400&fit=crop'),
    _product('توت أرضي', 'mulberry_1', 'توت أرضي أسود حلو', 28, false, true, 43, 1, 30, 'https://images.unsplash.com/photo-1558583055-d7ac00b1adca?w=400&fit=crop'),
    _product('يوزو', 'yuzu_1', 'يوزو ياباني عطري حامض', 40, false, true, 20, 1, 15, 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=400&fit=crop'),
    _product('كومكوات', 'kumquat_1', 'كومكوات صغيرة تؤكل بقشرها', 30, false, true, 71, 1, 25, 'https://images.unsplash.com/photo-1597714026720-8f74c62310ba?w=400&fit=crop'),
    _product('لونجان', 'longan_1', 'لونجان حلوة شبيهة بالليتشي', 35, false, true, 60, 1, 20, 'https://images.unsplash.com/photo-1577003811926-53b099a67c02?w=400&fit=crop'),
    _product('فراولة بيضاء', 'strawberry_white', 'فراولة بيضاء يابانية نادرة', 60, false, true, 32, 1, 10, 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=400&fit=crop'),
    _product('توت غوجي', 'goji_berry', 'توت غوجي مجفف غني بمضادات الأكسدة', 50, false, true, 98, 12, 45, 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&fit=crop'),
    _product('أكاي بيري', 'acai_berry', 'أكاي بيري مجمدة للسموثي', 55, true, true, 70, 6, 60, 'https://images.unsplash.com/photo-1590004953392-5aba2e72269a?w=400&fit=crop'),
    _product('فاكهة الكاكايا', 'jackfruit_1', 'فاكهة الكاكايا الاستوائية الكبيرة', 25, false, false, 95, 1, 25, 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=400&fit=crop'),
    _product('دوريان', 'durian_1', 'دوريان ملك الفواكه بطعم فريد', 80, false, false, 147, 1, 10, 'https://images.unsplash.com/photo-1588929132893-e48d7fc33597?w=400&fit=crop'),
    _product('مانجوستين', 'mangosteen_1', 'مانجوستين ملكة الفواكه', 45, false, true, 73, 1, 15, 'https://images.unsplash.com/photo-1609842947419-ba4f04d5d60f?w=400&fit=crop'),

    // ========== SEASONAL (10) ==========
    _product('فراولة موسمية', 'strawberry_seasonal', 'فراولة الموسم الطازجة', 20, true, false, 33, 1, 200, 'https://images.unsplash.com/photo-1495570689269-d883b1224443?w=400&fit=crop'),
    _product('مشمش موسمي', 'apricot_seasonal', 'مشمش الموسم طازج من البستان', 18, false, true, 48, 1, 70, 'https://images.unsplash.com/photo-1592681742486-7b3b4e760b01?w=400&fit=crop'),
    _product('عنب موسمي', 'grape_seasonal', 'عنب الموسم الطازج', 16, false, false, 69, 1, 130, 'https://images.unsplash.com/photo-1596363505729-4190a9506133?w=400&fit=crop'),
    _product('خوخ موسمي', 'peach_seasonal', 'خوخ الموسم ناضج ومثالي', 15, false, false, 59, 1, 85, 'https://images.unsplash.com/photo-1629828874514-cee2d0e36e?w=400&fit=crop'),
    _product('تين موسمي', 'fig_seasonal', 'تين الموسم الطازج', 25, false, true, 74, 1, 60, 'https://images.unsplash.com/photo-1601379760883-1bb497c558e4?w=400&fit=crop'),
    _product('رمان موسمي', 'pomegranate_seasonal', 'رمان الموسم بحبات كبيرة', 20, false, true, 83, 3, 100, 'https://images.unsplash.com/photo-1541344999736-83ede5e82024?w=400&fit=crop'),
    _product('مانجو موسمية', 'mango_seasonal', 'مانجو الموسم المصرية', 28, true, false, 99, 1, 250, 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=400&fit=crop'),
    _product('بطيخ موسمي', 'watermelon_seasonal', 'بطيخ الصيف الطازج', 20, false, false, 30, 1, 300, 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400&fit=crop'),
    _product('كرز موسمي', 'cherry_seasonal', 'كرز الموسم الطازج', 35, false, true, 63, 1, 70, 'https://images.unsplash.com/photo-1528821128474-27f963b062bf?w=400&fit=crop'),
    _product('جوافة موسمية', 'guava_seasonal', 'جوافة الشتاء الطازجة', 12, false, false, 68, 1, 120, 'https://images.unsplash.com/photo-1536511132770-e5058c7e8c46?w=400&fit=crop'),
  ];
}

Map<String, dynamic> _product(
  String name,
  String code,
  String description,
  num price,
  bool isFeatured,
  bool isOrganic,
  int calories,
  int expirationMonths,
  int sellingCount,
  String imageUrl,
) {
  // Use picsum.photos as reliable fallback for image URLs
  final reliableUrl = 'https://picsum.photos/seed/$code/400/400';
  return {
    'name': name,
    'code': code,
    'description': description,
    'price': price,
    'isFeatured': isFeatured,
    'isOrganic': isOrganic,
    'numberOfCalories': calories,
    'expirationsMonths': expirationMonths,
    'sellingCount': sellingCount,
    'unitAmount': 1,
    'imageUrl': reliableUrl,
    'reviews': [],
  };
}
