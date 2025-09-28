import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/errors/failures.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> execute() async {
    return await repository.getProducts();
  }
}
