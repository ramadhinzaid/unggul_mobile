import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_item_entity.dart';

abstract class SaleRepository {
  Future<Either<ErrorEntity, SaleEntity>> getSales();
  Future<Either<ErrorEntity, SaleItemEntity>> getSaleItem(String id);
  Future<Either<ErrorEntity, String>> manageSale(
    String? id,
    SaleRequest? request,
  );
}
