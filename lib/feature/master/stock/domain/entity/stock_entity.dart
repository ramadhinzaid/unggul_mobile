import 'package:equatable/equatable.dart';

class StockEntity extends Equatable {
  final int? code;
  final String? message;
  final List<StockEntityData?>? dataDetail;

  const StockEntity({this.code, this.message, this.dataDetail});

  StockEntity copyWith({
    int? code,
    String? message,
    List<StockEntityData?>? dataDetail,
  }) {
    return StockEntity(
      code: code ?? this.code,
      message: message ?? this.message,
      dataDetail: dataDetail ?? this.dataDetail,
    );
  }

  @override
  List<Object?> get props => [code, message, dataDetail];
}

class StockEntityData extends Equatable {
  final String? id;
  final String? code;
  final String? name;
  final String? category;
  final double? price;
  final int? qty;

  const StockEntityData({
    this.id,
    this.code,
    this.name,
    this.category,
    this.price,
    this.qty,
  });

  StockEntityData copyWith({
    String? code,
    String? name,
    String? category,
    double? price,
    int? qty,
  }) {
    return StockEntityData(
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [id, code, name, category, price, qty];
}
