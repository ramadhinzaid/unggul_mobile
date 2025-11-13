import 'package:equatable/equatable.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';

class SaleEntity extends Equatable {
  final int? code;
  final String? message;
  final List<SaleEntityData?>? dataDetail;

  const SaleEntity({this.code, this.message, this.dataDetail});

  SaleEntity copyWith({
    int? code,
    String? message,
    List<SaleEntityData?>? dataDetail,
  }) {
    return SaleEntity(
      code: code ?? this.code,
      message: message ?? this.message,
      dataDetail: dataDetail ?? this.dataDetail,
    );
  }

  @override
  List<Object?> get props => [code, message, dataDetail];
}

class SaleEntityData extends Equatable {
  final String? note;
  final String? date;
  final CustomerEntityData? customer;
  final double? subtotal;
  final List<StockEntityData?>? products;

  const SaleEntityData({
    this.note,
    this.date,
    this.customer,
    this.subtotal,
    this.products,
  });

  SaleEntityData copyWith({
    String? note,
    String? date,
    CustomerEntityData? customer,
    double? subtotal,
    List<StockEntityData?>? products,
  }) {
    return SaleEntityData(
      note: note ?? this.note,
      date: date ?? this.date,
      customer: customer ?? this.customer,
      subtotal: subtotal ?? this.subtotal,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [note, date, customer, subtotal, products];
}
