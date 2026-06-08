import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/entities/product_entity.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  final ProductsRepo productsRepo;

  int get productsLength {
    final currentState = state;
    if (currentState is ProductsSuccess) return currentState.products.length;
    if (currentState is BestSellingProductsSuccess)
      return currentState.products.length;
    return 0;
  }

  Future<void> getProducts() async {
    emit(ProductsLoading());

    final result = await productsRepo.getProducts();

    result.fold(
      (failure) => emit(ProductsFailure(failure.message)),
      (products) => emit(ProductsSuccess(products)),
    );
  }

  Future<void> getBestSellingProducts() async {
    emit(ProductsLoading());

    final result = await productsRepo.getBestSellingProducts();

    result.fold(
      (failure) => emit(ProductsFailure(failure.message)),
      (products) {
        emit(BestSellingProductsSuccess(products));
      },
    );
  }
}
