import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/customer/domain/repository/customer_repository.dart';

class CustomerManageUsecase {
  final CustomerRepository _repository;
  CustomerManageUsecase(this._repository);

  Future<Either<ErrorEntity, String>> call({
    String? id,
    CustomerModelData? request,
  }) async => await _repository.manageCustomer(id, request);
}
