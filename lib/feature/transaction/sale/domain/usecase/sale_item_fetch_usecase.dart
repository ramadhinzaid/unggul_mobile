import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_item_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/repository/sale_repository.dart';

class SaleItemFetchUsecase {
  final SaleRepository _repository;
  SaleItemFetchUsecase(this._repository);

  Future<Either<ErrorEntity, SaleItemEntity>> call(String id) async =>
      await _repository.getSaleItem(id);
}
