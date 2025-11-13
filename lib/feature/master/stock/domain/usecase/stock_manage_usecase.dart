import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/master/stock/domain/repository/stock_repository.dart';

class StockManageUsecase {
  final StockRepository _repository;
  StockManageUsecase(this._repository);

  Future<Either<ErrorEntity, String>> call({
    String? id,
    StockModelData? request,
  }) async => await _repository.manageStock(id, request);
}
