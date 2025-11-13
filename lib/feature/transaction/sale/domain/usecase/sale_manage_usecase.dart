import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/repository/sale_repository.dart';

class SaleManageUsecase {
  final SaleRepository _repository;
  SaleManageUsecase(this._repository);

  Future<Either<ErrorEntity, String>> call({
    String? id,
    SaleRequest? request,
  }) async => await _repository.manageSale(id, request);
}
