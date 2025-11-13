import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/data/source/stock_remote_source.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';
import 'package:unggul_mobile/feature/master/stock/domain/repository/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  StockRepositoryImpl(this._source);
  final StockRemoteSource _source;

  @override
  Future<Either<ErrorEntity, StockEntity>> getStocks() async {
    try {
      final result = await _source.getStocks();
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
  Future<Either<ErrorEntity, String>> manageStock(
    String? id,
    StockModelData? request,
  ) async {
    try {
      DefaultResponse? result;
      if ((id ?? '').isNotEmpty) {
        result = await _source.deleteStock(id!);
      } else if ((request?.id ?? '').isNotEmpty) {
        result = await _source.updateStock(request!);
      } else if (request != null) {
        result = await _source.createStock(request);
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
