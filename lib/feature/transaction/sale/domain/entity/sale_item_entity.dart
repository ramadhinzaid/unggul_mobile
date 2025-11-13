import 'package:equatable/equatable.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';

class SaleItemEntity extends Equatable {
  final int? code;
  final String? message;
  final SaleItemEntityData? dataDetail;

  const SaleItemEntity({this.code, this.message, this.dataDetail});

  SaleItemEntity copyWith({
    int? code,
    String? message,
    SaleItemEntityData? dataDetail,
  }) {
    return SaleItemEntity(
      code: code ?? this.code,
      message: message ?? this.message,
      dataDetail: dataDetail ?? this.dataDetail,
    );
  }

  @override
  List<Object?> get props => [code, message, dataDetail];
}

class SaleItemEntityData extends Equatable {
  final String? note;
  final String? date;
  final CustomerEntityData? customer;
  final double? subtotal;
  final List<StockEntityData?>? products;

  const SaleItemEntityData({
    this.note,
    this.date,
    this.customer,
    this.subtotal,
    this.products,
  });

  @override
  List<Object?> get props => [note, date, customer, subtotal, products];
}
