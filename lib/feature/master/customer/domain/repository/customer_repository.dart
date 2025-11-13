import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';

abstract class CustomerRepository {
  Future<Either<ErrorEntity, CustomerEntity>> getCustomers();
  Future<Either<ErrorEntity, String>> manageCustomer(
    String? id,
    CustomerModelData? request,
  );
}
