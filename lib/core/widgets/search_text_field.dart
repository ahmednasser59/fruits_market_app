import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.onChanged, this.onFilterTap});

  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 9,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            child: Center(
              child: SvgPicture.asset(Assets.imagesSearchIcon),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onFilterTap ??
                () => _showFilterBottomSheet(context),
            child: SizedBox(
              width: 20,
              child: Center(
                child: SvgPicture.asset(
                  Assets.imagesFilter,
                ),
              ),
            ),
          ),
          hintStyle: TextStyles.regular13.copyWith(
            color: const Color(0xFF949D9E),
          ),
          hintText: 'ابحث عن.......',
          filled: true,
          fillColor: Colors.white,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => const FilterBottomSheet(),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool organicOnly = false;
  RangeValues priceRange = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'تصفية المنتجات',
            style: TextStyles.bold19,
          ),
          const SizedBox(height: 20),

          // Price range
          Text(
            'نطاق السعر',
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF4E5556),
            ),
          ),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: AppColors.primaryColor,
            labels: RangeLabels(
              '${priceRange.start.round()} جنيه',
              '${priceRange.end.round()} جنيه',
            ),
            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${priceRange.start.round()} جنيه',
                  style: TextStyles.regular13),
              Text('${priceRange.end.round()} جنيه',
                  style: TextStyles.regular13),
            ],
          ),
          const SizedBox(height: 16),

          // Organic toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'منتجات عضوية فقط',
                style: TextStyles.semiBold16.copyWith(
                  color: const Color(0xFF4E5556),
                ),
              ),
              Switch(
                value: organicOnly,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    organicOnly = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'organic': organicOnly,
                  'minPrice': priceRange.start,
                  'maxPrice': priceRange.end,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'تطبيق',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
