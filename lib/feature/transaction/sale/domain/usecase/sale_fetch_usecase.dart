import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/repository/sale_repository.dart';

class SaleFetchUsecase {
  final SaleRepository _repository;
  SaleFetchUsecase(this._repository);

  Future<Either<ErrorEntity, SaleEntity>> call() async =>
      await _repository.getSales();
}
