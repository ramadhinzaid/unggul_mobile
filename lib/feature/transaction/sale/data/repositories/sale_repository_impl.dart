import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/source/sale_remote_source.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_item_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/repository/sale_repository.dart';

class SaleRepositoryImpl extends SaleRepository {
  final SaleRemoteSource _source;
  SaleRepositoryImpl(this._source);

  @override
  Future<Either<ErrorEntity, SaleItemEntity>> getSaleItem(String id) async {
    try {
      final result = await _source.getSaleItem(id);
      if (result.statusCode == 200) {
        return Right(result.toEntity());
      }
      return Left(
        ErrorEntity(code: result.statusCode, message: result.message),
      );
    } catch (e) {
      return Left(ErrorEntity(error: e));
    }
  }

  @override
  Future<Either<ErrorEntity, SaleEntity>> getSales() async {
    try {
      final result = await _source.getSales();
      if (result.statusCode == 200) {
        return Right(result.toEntity());
      }
      return Left(
        ErrorEntity(code: result.statusCode, message: result.message),
      );
    } catch (e) {
      return Left(ErrorEntity(error: e));
    }
  }

  @override
  Future<Either<ErrorEntity, String>> manageSale(
    String? id,
    SaleRequest? request,
  ) async {
    try {
      DefaultResponse? result;
      if ((id ?? '').isNotEmpty) {
        if (request != null) {
          result = await _source.updateSale(id!, request);
        } else {
          result = await _source.deleteSale(id!);
        }
      } else if (request != null) {
        result = await _source.createSale(request);
      } else {
        return Left(ErrorEntity(message: 'undefined error [Request Null]'));
      }

      if (result.statusCode == 200 || result.statusCode == 201) {
        return Right(result.toEntity());
      }
      return Left(
        ErrorEntity(code: result.statusCode, message: result.message),
      );
    } catch (e) {
      return Left(ErrorEntity(error: e));
    }
  }
}
