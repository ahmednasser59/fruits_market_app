import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/entities/product_entity.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  final ProductsRepo productsRepo;
  List<ProductEntity> _allProducts = [];

  int get productsLength {
    final currentState = state;
    if (currentState is ProductsSuccess) {
      return currentState.products.length;
    }
    if (currentState is BestSellingProductsSuccess) {
      return currentState.products.length;
    }
    return 0;
  }

  Future<void> getProducts() async {
    emit(ProductsLoading());

    final result = await productsRepo.getProducts();

    result.fold(
      (failure) => emit(ProductsFailure(failure.message)),
      (products) {
        _allProducts = products;
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> getBestSellingProducts() async {
    emit(ProductsLoading());

    final result = await productsRepo.getBestSellingProducts();

    result.fold(
      (failure) => emit(ProductsFailure(failure.message)),
      (products) {
        _allProducts = products;
        emit(BestSellingProductsSuccess(products));
      },
    );
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductsSuccess(_allProducts));
      return;
    }
    final filtered = _allProducts.where((product) {
      return product.name.contains(query) ||
          product.description.contains(query);
    }).toList();
    emit(ProductsSuccess(filtered));
  }

  void filterProducts({
    required double minPrice,
    required double maxPrice,
    required bool organicOnly,
  }) {
    var filtered = _allProducts.where((product) {
      final priceMatch =
          product.price >= minPrice && product.price <= maxPrice;
      final organicMatch = !organicOnly || product.isOrganic;
      return priceMatch && organicMatch;
    }).toList();
    emit(ProductsSuccess(filtered));
  }
}
