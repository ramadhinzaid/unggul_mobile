import 'package:unggul_mobile/core/config/config.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';

abstract class StockRemoteSource {
  Future<StockModel> getStocks();
  Future<DefaultResponse> createStock(StockModelData request);
  Future<DefaultResponse> updateStock(StockModelData request);
  Future<DefaultResponse> deleteStock(String id);
}

class StockRemoteSourceImpl extends StockRemoteSource {
  StockRemoteSourceImpl(this._api);
  final API _api;

  @override
  Future<DefaultResponse> createStock(StockModelData request) async {
    try {
      final result = await _api.post('/stocks', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 201) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> deleteStock(String id) async {
    try {
      final result = await _api.delete('/stocks/$id');
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StockModel> getStocks() async {
    try {
      final result = await _api.get('/stocks');
      final response = StockModel.fromJson(result.data);
      if (result.statusCode == 200) return response;
      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DefaultResponse> updateStock(StockModelData request) async {
    try {
      if ((request.code ?? '').isEmpty) {
        throw ('invalid stock code');
      }
      final id = request.id;
      final result = await _api.put('/stocks/$id', body: request.toJson());
      final response = DefaultResponse.fromJson(result.data);
      if (result.statusCode == 200) return response;

      throw (response.message ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
