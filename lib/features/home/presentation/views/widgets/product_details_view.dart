import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/entities/product_entity.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
import 'package:fruits_hub/core/widgets/custom_network_image.dart';
import 'package:fruits_hub/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productEntity});

  static const routeName = 'product_details';
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          productEntity.name,
          style: TextStyles.bold19,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image
            Container(
              height: 250,
              color: const Color(0xFFF3F5F7),
              child: Center(
                child: productEntity.imageUrl != null
                    ? CustomNetworkImage(imageUrl: productEntity.imageUrl!)
                    : const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productEntity.name,
                          style: TextStyles.bold23,
                        ),
                      ),
                      Text(
                        '${productEntity.price} جنيه/كيلو',
                        style: TextStyles.bold16.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'الوصف',
                    style: TextStyles.bold16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productEntity.description,
                    style: TextStyles.regular16.copyWith(
                      color: const Color(0xFF4E5556),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Info chips
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildInfoChip(
                        icon: Icons.local_fire_department,
                        label: '${productEntity.numberOfCalories} سعرة',
                      ),
                      _buildInfoChip(
                        icon: Icons.calendar_month,
                        label:
                            '${productEntity.expirationsMonths} شهر صلاحية',
                      ),
                      if (productEntity.isOrganic)
                        _buildInfoChip(
                          icon: Icons.eco,
                          label: 'عضوي',
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Reviews section
                  if (productEntity.reviews.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'التقييمات (${productEntity.reviews.length})',
                      style: TextStyles.bold16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...productEntity.reviews.map(
                      (review) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F5F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    review.name,
                                    style: TextStyles.semiBold13,
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        Icons.star,
                                        size: 16,
                                        color: i < review.ratting
                                            ? AppColors.secondaryColor
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.reviewDescription,
                                style: TextStyles.regular13.copyWith(
                                  color: const Color(0xFF4E5556),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Add to cart button
                  CustomButton(
                    onPressed: () {
                      context.read<CartCubit>().addProduct(productEntity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تمت إضافة ${productEntity.name} إلى السلة'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    },
                    text: 'أضف إلى السلة',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyles.semiBold11.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
