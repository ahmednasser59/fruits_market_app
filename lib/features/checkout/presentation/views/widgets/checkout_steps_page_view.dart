import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/order_summry_widget.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_address_widget.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatelessWidget {
  const CheckoutStepsPageView({
    super.key,
    required this.valueListenable,
    required this.pageController,
    required this.formKey,
  });

  final ValueListenable<AutovalidateMode> valueListenable;
  final PageController pageController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const ShippingSection(),
        AddressInputSection(
          formKey: formKey,
          valueListenable: valueListenable,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShippingAddressWidget(pageController: pageController),
            const SizedBox(height: 16),
            const OrderSummryWidget(),
          ],
        ),
      ],
    );
  }
}
