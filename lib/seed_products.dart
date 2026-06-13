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

  final products = [
    {
      'name': 'تفاح أحمر',
      'code': 'apple_red',
      'description': 'تفاح أحمر طازج ولذيذ، غني بالألياف ومضادات الأكسدة.',
      'price': 15,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/5KBFTQE.png',
      'expirationsMonths': 1,
      'numberOfCalories': 95,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 120,
      'reviews': [
        {
          'name': 'أحمد',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 5,
          'date': '2024-12-01',
          'reviewDescription': 'تفاح ممتاز وطازج جداً',
        },
      ],
    },
    {
      'name': 'موز',
      'code': 'banana',
      'description': 'موز طازج غني بالبوتاسيوم والطاقة.',
      'price': 10,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/wOA3VNT.png',
      'expirationsMonths': 1,
      'numberOfCalories': 105,
      'unitAmount': 1,
      'isOrganic': false,
      'sellingCount': 200,
      'reviews': [
        {
          'name': 'سارة',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 4,
          'date': '2024-11-20',
          'reviewDescription': 'موز لذيذ وطازج',
        },
      ],
    },
    {
      'name': 'برتقال',
      'code': 'orange',
      'description': 'برتقال طازج غني بفيتامين سي.',
      'price': 12,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/UHmOi2g.png',
      'expirationsMonths': 2,
      'numberOfCalories': 62,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 150,
      'reviews': [
        {
          'name': 'محمد',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 5,
          'date': '2024-12-05',
          'reviewDescription': 'برتقال حلو وطازج',
        },
      ],
    },
    {
      'name': 'فراولة',
      'code': 'strawberry',
      'description': 'فراولة طازجة حمراء ولذيذة، مثالية للعصائر والحلويات.',
      'price': 25,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/3y6oQFC.png',
      'expirationsMonths': 1,
      'numberOfCalories': 50,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 180,
      'reviews': [
        {
          'name': 'فاطمة',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 5,
          'date': '2024-12-10',
          'reviewDescription': 'فراولة رائعة!',
        },
      ],
    },
    {
      'name': 'عنب أخضر',
      'code': 'grapes_green',
      'description': 'عنب أخضر طازج ومقرمش، مثالي كوجبة خفيفة.',
      'price': 20,
      'isFeatured': false,
      'imageUrl': 'https://i.imgur.com/Oa9cG1r.png',
      'expirationsMonths': 1,
      'numberOfCalories': 70,
      'unitAmount': 1,
      'isOrganic': false,
      'sellingCount': 90,
      'reviews': [],
    },
    {
      'name': 'بطيخ',
      'code': 'watermelon',
      'description': 'بطيخ أحمر طازج ومنعش، مثالي لفصل الصيف.',
      'price': 30,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/FvGz0sB.png',
      'expirationsMonths': 1,
      'numberOfCalories': 86,
      'unitAmount': 1,
      'isOrganic': false,
      'sellingCount': 250,
      'reviews': [
        {
          'name': 'علي',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 4,
          'date': '2024-11-15',
          'reviewDescription': 'بطيخ حلو ومنعش',
        },
      ],
    },
    {
      'name': 'مانجو',
      'code': 'mango',
      'description': 'مانجو ناضجة وحلوة، ملكة الفواكه.',
      'price': 35,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/Zyj2rJd.png',
      'expirationsMonths': 1,
      'numberOfCalories': 99,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 300,
      'reviews': [
        {
          'name': 'نور',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 5,
          'date': '2024-12-08',
          'reviewDescription': 'مانجو لذيذة جداً',
        },
        {
          'name': 'خالد',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 4,
          'date': '2024-12-02',
          'reviewDescription': 'طعم ممتاز',
        },
      ],
    },
    {
      'name': 'أناناس',
      'code': 'pineapple',
      'description': 'أناناس استوائي طازج، حلو وحامض.',
      'price': 28,
      'isFeatured': false,
      'imageUrl': 'https://i.imgur.com/7RVfPkE.png',
      'expirationsMonths': 2,
      'numberOfCalories': 82,
      'unitAmount': 1,
      'isOrganic': false,
      'sellingCount': 75,
      'reviews': [],
    },
    {
      'name': 'كيوي',
      'code': 'kiwi',
      'description': 'كيوي طازج غني بفيتامين سي والألياف.',
      'price': 18,
      'isFeatured': false,
      'imageUrl': 'https://i.imgur.com/GdbGKDQ.png',
      'expirationsMonths': 2,
      'numberOfCalories': 42,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 60,
      'reviews': [
        {
          'name': 'ليلى',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 4,
          'date': '2024-11-28',
          'reviewDescription': 'كيوي طازج وحامض بشكل مثالي',
        },
      ],
    },
    {
      'name': 'رمان',
      'code': 'pomegranate',
      'description': 'رمان طازج مليء بالبذور الحمراء اللذيذة.',
      'price': 22,
      'isFeatured': true,
      'imageUrl': 'https://i.imgur.com/MGqk3wP.png',
      'expirationsMonths': 3,
      'numberOfCalories': 83,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 110,
      'reviews': [
        {
          'name': 'عمر',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 5,
          'date': '2024-12-12',
          'reviewDescription': 'رمان ممتاز ولذيذ',
        },
      ],
    },
    {
      'name': 'تين',
      'code': 'fig',
      'description': 'تين طازج حلو وغني بالمعادن والألياف.',
      'price': 30,
      'isFeatured': false,
      'imageUrl': 'https://i.imgur.com/LNrOLN0.png',
      'expirationsMonths': 1,
      'numberOfCalories': 74,
      'unitAmount': 1,
      'isOrganic': true,
      'sellingCount': 45,
      'reviews': [],
    },
    {
      'name': 'خوخ',
      'code': 'peach',
      'description': 'خوخ طازج ناعم وحلو، مثالي كوجبة صحية.',
      'price': 16,
      'isFeatured': false,
      'imageUrl': 'https://i.imgur.com/0HqJGlq.png',
      'expirationsMonths': 1,
      'numberOfCalories': 59,
      'unitAmount': 1,
      'isOrganic': false,
      'sellingCount': 85,
      'reviews': [
        {
          'name': 'هدى',
          'image': 'https://i.imgur.com/JQAhXKf.png',
          'ratting': 4,
          'date': '2024-11-25',
          'reviewDescription': 'خوخ لذيذ وطازج',
        },
      ],
    },
  ];

  for (var product in products) {
    await collection.doc(product['code'] as String).set(product);
    debugPrint('✅ Added: ${product['name']}');
  }

  debugPrint('\n✅ Seeding complete! ${products.length} products added.');
  debugPrint('You can now stop this app and run your main app normally.');
}
