import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';

abstract class StockRepository {
  Future<Either<ErrorEntity, StockEntity>> getStocks();
  Future<Either<ErrorEntity, String>> manageStock(
    String? id,
    StockModelData? request,
  );
}
