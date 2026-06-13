import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruits_hub/core/entities/product_entity.dart';
import 'package:fruits_hub/core/helper_functions/get_dummy_product.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:fruits_hub/core/services/get_it_service.dart';
import 'package:fruits_hub/core/widgets/custom_error_widget.dart';
import 'package:fruits_hub/core/widgets/fruit_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellingViewBody extends StatelessWidget {
  const BestSellingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCubit(getIt.get<ProductsRepo>())..getBestSellingProducts(),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is BestSellingProductsSuccess) {
            return _buildGrid(state.products);
          } else if (state is ProductsFailure) {
            return Center(child: CustomErrorWidget(text: state.errMessage));
          } else {
            return Skeletonizer(
              enabled: true,
              child: _buildGrid(getDummyProducts()),
            );
          }
        },
      ),
    );
  }

  Widget _buildGrid(List<ProductEntity> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 163 / 214,
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return FruitItem(
            productEntity: products[index],
          );
        },
      ),
    );
  }
}
