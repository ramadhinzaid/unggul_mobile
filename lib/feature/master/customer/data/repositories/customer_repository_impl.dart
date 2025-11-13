import 'package:dartz/dartz.dart';
import 'package:unggul_mobile/core/util/default_response.dart';
import 'package:unggul_mobile/core/util/error_entity.dart';
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/customer/data/source/customer_remote_source.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/customer/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  CustomerRepositoryImpl(this._source);
  final CustomerRemoteSource _source;

  @override
  Future<Either<ErrorEntity, CustomerEntity>> getCustomers() async {
    try {
      final result = await _source.getCustomers();
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
  Future<Either<ErrorEntity, String>> manageCustomer(
    String? id,
    CustomerModelData? request,
  ) async {
    try {
      DefaultResponse? result;
      if ((id ?? '').isNotEmpty) {
        result = await _source.deleteCustomer(id!);
      } else if ((request?.id ?? '').isNotEmpty) {
        result = await _source.updateCustomer(request!);
      } else if (request != null) {
        result = await _source.createCustomer(request);
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
