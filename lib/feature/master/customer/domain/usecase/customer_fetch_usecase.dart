import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/customer/domain/repository/customer_repository.dart';

class CustomerFetchUsecase {
  final CustomerRepository _repository;
  CustomerFetchUsecase(this._repository);

  Future<Either<ErrorEntity, CustomerEntity>> call() async =>
      await _repository.getCustomers();
}
