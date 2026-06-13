import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/checkout/domain/entites/order_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/payment_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_text_styles.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    log(context.read<OrderInputEntity>().toString());
    return PaymentItem(
      tile: 'عنوان التوصيل',
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.imagesLocation,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              '${context.read<OrderInputEntity>().shippingAddressEntity}',
              textAlign: TextAlign.right,
              style: TextStyles.regular13.copyWith(
                color: const Color(0xFF4E5556),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.imagesEdit,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'تعديل',
                    style: TextStyles.semiBold13.copyWith(
                      color: const Color(0xFF949D9E),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
