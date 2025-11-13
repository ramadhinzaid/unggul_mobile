import 'package:unggul_mobile/feature/master/customer/data/model/customer_model.dart';
import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_item_entity.dart';

class SaleItemModel {
  int? statusCode;
  String? message;
  SaleItemModelData? dataDetail;

  SaleItemModel({this.statusCode, this.message, this.dataDetail});

  SaleItemModel.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status_code']?.toString() ?? '');
    message = json['message']?.toString();
    dataDetail = json['data'] != null
        ? SaleItemModelData.fromJson(json['data'])
        : null;
  }

  SaleItemEntity toEntity() => SaleItemEntity(
    code: statusCode,
    message: message,
    dataDetail: dataDetail?.toEntity(),
  );
}

class SaleItemModelData {
  String? note;
  String? date;
  CustomerModelData? customer;
  double? subtotal;
  List<StockModelData?>? products;

  SaleItemModelData({
    this.note,
    this.date,
    this.customer,
    this.subtotal,
    this.products,
  });

  SaleItemModelData.fromJson(Map<String, dynamic> json) {
    note = json['note']?.toString();
    date = json['date']?.toString();
    customer = json['customer'] != null
        ? CustomerModelData.fromJson(json['customer'])
        : null;
    subtotal = double.tryParse(json['subtotal']?.toString() ?? '');
    if (json['products'] != null) {
      products = <StockModelData?>[];
      for (final v in json['products']) {
        products?.add(StockModelData.fromJson(v));
      }
    }
  }

  SaleItemEntityData toEntity() => SaleItemEntityData(
    note: note,
    date: date,
    subtotal: subtotal,
    customer: customer?.toEntity(),
    products: products?.map((e) => e?.toEntity()).toList(),
  );
}
