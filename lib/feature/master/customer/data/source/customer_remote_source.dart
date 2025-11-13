import 'package:unggul_mobile/core/config/config.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';

abstract class CustomerRemoteSource {
  Future<CustomerModel> getCustomers();
  Future<DefaultResponse> createCustomer(CustomerModelData request);
  Future<DefaultResponse> updateCustomer(CustomerModelData request);
  Future<DefaultResponse> deleteCustomer(String id);
}

class CustomerRemoteSourceImpl extends CustomerRemoteSource {
  CustomerRemoteSourceImpl(this._api);
  final API _api;

  @override
  Future<DefaultResponse> createCustomer(CustomerModelData request) async {
    try {
      final result = await _api.post('/customers', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 201) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> deleteCustomer(String id) async {
    try {
      final result = await _api.delete('/customers/$id');
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CustomerModel> getCustomers() async {
    try {
      final result = await _api.get('/customers');
      final response = CustomerModel.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> updateCustomer(CustomerModelData request) async {
    try {
      if ((request.id ?? '').isEmpty) {
        throw ('invalid customer id');
      }
      final id = request.id;
      final result = await _api.put('/customers/$id', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
