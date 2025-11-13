import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';

class StockModel {
  int? statusCode;
  String? message;
  List<StockModelData?>? dataDetail;

  StockModel({this.statusCode, this.message, this.dataDetail});

  StockModel.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status_code']?.toString() ?? '');
    message = json['message']?.toString();
    if (json['data'] != null) {
      dataDetail = <StockModelData?>[];
      for (final v in json['data']) {
        dataDetail?.add(StockModelData.fromJson(v));
      }
    }
  }

  StockEntity toEntity() => StockEntity(
    code: statusCode,
    message: message,
    dataDetail: dataDetail?.map((e) => e?.toEntity()).toList(),
  );
}

class StockModelData {
  String? id;
  String? code;
  String? name;
  String? category;
  double? price;
  int? qty;

  StockModelData({
    this.id,
    this.code,
    this.name,
    this.category,
    this.price,
    this.qty,
  });

  StockModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    code = json['code']?.toString();
    name = json['name']?.toString();
    category = json['category']?.toString();
    price = double.tryParse(json['price']?.toString() ?? '');
    qty = int.tryParse(json['qty']?.toString() ?? '');
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['code'] = code ?? '';
    data['name'] = name ?? '';
    data['category'] = category ?? '';
    data['price'] = price?.toString() ?? '';
    return data;
  }

  Map<String, String> toJsonSale() {
    final Map<String, String> data = <String, String>{};
    data['code'] = code ?? '';
    if ((qty ?? 0) != 0) {
      data['qty'] = qty?.toString() ?? '';
    }
    return data;
  }

  StockEntityData toEntity() => StockEntityData(
    id: id,
    code: code,
    category: category,
    name: name,
    price: price,
    qty: qty,
  );
}
