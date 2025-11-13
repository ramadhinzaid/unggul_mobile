import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';

class SaleModel {
  int? statusCode;
  String? message;
  List<SaleModelData?>? dataDetail;

  SaleModel({this.statusCode, this.message, this.dataDetail});

  SaleModel.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status_code']?.toString() ?? '');
    message = json['message']?.toString();
    if (json['data'] != null) {
      dataDetail = <SaleModelData?>[];
      for (final v in json['data']) {
        dataDetail?.add(SaleModelData.fromJson(v));
      }
    }
  }

  SaleEntity toEntity() => SaleEntity(
    code: statusCode,
    message: message,
    dataDetail: dataDetail?.map((e) => e?.toEntity()).toList(),
  );
}

class SaleModelData {
  String? note;
  String? date;
  CustomerModelData? customer;
  double? subtotal;
  List<StockModelData?>? products;

  SaleModelData({
    this.note,
    this.date,
    this.customer,
    this.subtotal,
    this.products,
  });

  SaleModelData.fromJson(Map<String, dynamic> json) {
    note = json['note']?.toString();
    date = json['date']?.toString();
    customer = json['customer'] != null
        ? CustomerModelData.fromJson(json['customer'])
        : null;
    subtotal = double.tryParse(json['subtotal']?.toString() ?? '');
    if (json['products'] != null && json['products'] is List) {
      products = <StockModelData?>[];
      for (final v in json['products']) {
        products?.add(StockModelData.fromJson(v));
      }
    }
  }

  SaleEntityData toEntity() => SaleEntityData(
    note: note,
    date: date,
    subtotal: subtotal,
    customer: customer?.toEntity(),
    products: products?.map((e) => e?.toEntity()).toList(),
  );
}
