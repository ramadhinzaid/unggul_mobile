import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int? code;
  final String? message;
  final List<CustomerEntityData?>? dataDetail;

  const CustomerEntity({this.code, this.message, this.dataDetail});

  CustomerEntity copyWith({
    int? code,
    String? message,
    List<CustomerEntityData?>? dataDetail,
  }) {
    return CustomerEntity(
      code: code ?? this.code,
      message: message ?? this.message,
      dataDetail: dataDetail ?? this.dataDetail,
    );
  }

  @override
  List<Object?> get props => [code, message, dataDetail];
}

class CustomerEntityData extends Equatable {
  final String? id;
  final String? name;
  final String? domicile;
  final String? gender;

  const CustomerEntityData({this.id, this.name, this.domicile, this.gender});

  CustomerEntityData copyWith({
    String? name,
    String? domicile,
    String? gender,
  }) {
    return CustomerEntityData(
      id: id,
      name: name ?? this.name,
      domicile: domicile ?? this.domicile,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [id, name, domicile, gender];
}
