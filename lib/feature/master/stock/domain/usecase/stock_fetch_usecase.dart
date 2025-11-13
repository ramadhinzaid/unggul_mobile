import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';
import 'package:unggul_mobile/feature/master/stock/domain/repository/stock_repository.dart';

class StockFetchUsecase {
  final StockRepository _repository;
  StockFetchUsecase(this._repository);

  Future<Either<ErrorEntity, StockEntity>> call() async =>
      await _repository.getStocks();
}
