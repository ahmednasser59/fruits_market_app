import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/entities/product_entity.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/core/models/product_model.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:fruits_hub/core/services/data_service.dart';
import 'package:fruits_hub/core/utils/backend_endpoint.dart';

/// Repository implementation for fetching products from Firestore
///
/// Implements safe data parsing, error handling, and null safety
class ProductsRepoImpl extends ProductsRepo {
  final DatabaseService databaseService;

  ProductsRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      final data = await databaseService.getData(
        path: BackendEndpoint.getProducts,
        query: {'limit': 10, 'orderBy': 'sellingCount', 'descending': true},
      );

      return _parseProducts(data);
    } catch (e) {
      return left(ServerFailure(_handleError(e)));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final data = await databaseService.getData(
        path: BackendEndpoint.getProducts,
      );

      return _parseProducts(data);
    } catch (e) {
      return left(ServerFailure(_handleError(e)));
    }
  }

  /// Safely parses dynamic data into ProductEntity list
  ///
  /// Features:
  /// - No unsafe casting
  /// - Handles null data
  /// - Validates data types
  /// - Skips invalid items without failing entire request
  /// - Detailed error logging
  Either<Failure, List<ProductEntity>> _parseProducts(dynamic data) {
    try {
      // ✅ Step 1: Null safety check
      if (data == null) {
        debugPrint('⚠️ Warning: Received null data from backend');
        return left(ServerFailure('No products found'));
      }

      // ✅ Step 2: Safe type validation (no casting)
      if (data is! List) {
        final actualType = data.runtimeType;
        debugPrint(
          '❌ Error: Expected List but got $actualType\n'
          '   Data: $data',
        );
        return left(
          ServerFailure('Invalid data format: expected List, got $actualType'),
        );
      }

      // ✅ Step 3: Handle empty list
      if (data.isEmpty) {
        debugPrint('ℹ️ Info: Empty products list received');
        return right([]);
      }

      // ✅ Step 4: Safe iteration and conversion
      final List<ProductEntity> products = [];

      for (int index = 0; index < data.length; index++) {
        try {
          final item = data[index];

          // Validate each item is a Map
          if (item is! Map<String, dynamic>) {
            final actualType = item.runtimeType;
            debugPrint(
              '⚠️ Warning: Skipping invalid item at index $index\n'
              '   Expected Map<String, dynamic> but got $actualType\n'
              '   Data: $item',
            );
            continue; // Skip invalid items
          }

          // Convert to ProductModel
          final productModel = ProductModel.fromJson(item);

          // Convert to ProductEntity
          final productEntity = productModel.toEntity();
          products.add(productEntity);
        } catch (itemError) {
          debugPrint(
            '❌ Error parsing product at index $index:\n'
            '   Error: $itemError\n'
            '   Data: ${data[index]}',
          );
          // Continue to next item instead of failing entire request
          continue;
        }
      }

      // ✅ Step 5: Validate parsed results
      if (products.isEmpty) {
        debugPrint('⚠️ Warning: No valid products could be parsed from data');
        return left(
          ServerFailure(
              'No valid products could be parsed from the received data'),
        );
      }

      debugPrint('✅ Success: Parsed ${products.length} products');
      return right(products);
    } catch (e) {
      debugPrint(
        '❌ Critical Error in _parseProducts:\n'
        '   Error: $e\n'
        '   Type: ${e.runtimeType}',
      );
      return left(ServerFailure(_handleError(e)));
    }
  }

  /// Translates exceptions into user-friendly error messages
  ///
  /// Provides specific error messages based on exception type
  /// and logs detailed information for debugging
  String _handleError(dynamic error) {
    // Already a ServerFailure
    if (error is ServerFailure) {
      return error.message;
    }

    final errorMessage = error.toString();

    // Log detailed error information
    debugPrint(
      '❌ Exception Details:\n'
      '   Type: ${error.runtimeType}\n'
      '   Message: $errorMessage\n'
      '   Stack Trace: ${StackTrace.current}',
    );

    // Type-specific error handling
    if (error is TypeError) {
      return 'Data type error: Invalid format from backend. Please contact support.';
    }

    if (error is FormatException) {
      return 'Invalid format: ${error.message}';
    }

    if (error is NoSuchMethodError) {
      return 'Data structure mismatch: Missing required fields';
    }

    if (error is UnsupportedError) {
      return 'Operation not supported: $errorMessage';
    }

    if (error is RangeError) {
      return 'Data range error: Invalid data received';
    }

    // Fallback for unknown errors
    return 'Failed to fetch products: $errorMessage';
  }
}
