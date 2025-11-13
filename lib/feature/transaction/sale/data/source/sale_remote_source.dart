import 'package:unggul_mobile/core/config/config.dart';
import 'package:unggul_mobile/core/util/default_response.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_item_model.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_model.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/model/sale_request.dart';

abstract class SaleRemoteSource {
  Future<SaleModel> getSales();
  Future<SaleItemModel> getSaleItem(String id);
  Future<DefaultResponse> createSale(SaleRequest request);
  Future<DefaultResponse> updateSale(String id, SaleRequest request);
  Future<DefaultResponse> deleteSale(String id);
}

class SaleRemoteSourceImpl extends SaleRemoteSource {
  SaleRemoteSourceImpl(this._api);
  final API _api;

  @override
  Future<DefaultResponse> createSale(SaleRequest request) async {
    try {
      final result = await _api.post('/sales', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 201) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> deleteSale(String id) async {
    try {
      final result = await _api.delete('/sales/$id');
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SaleModel> getSales() async {
    try {
      final result = await _api.get('/sales');
      final response = SaleModel.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> updateSale(String id, SaleRequest request) async {
    try {
      if (id.isEmpty) {
        throw ('invalid sale note');
      }
      final result = await _api.put('/sales/$id', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SaleItemModel> getSaleItem(String id) async {
    try {
      final result = await _api.get('/sales/$id');
      final response = SaleItemModel.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
