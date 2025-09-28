import 'package:dartz/dartz.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
