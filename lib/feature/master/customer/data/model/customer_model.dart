import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';

class CustomerModel {
  int? statusCode;
  String? message;
  List<CustomerModelData?>? dataDetail;

  CustomerModel({this.statusCode, this.message, this.dataDetail});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status_code']?.toString() ?? '');
    message = json['message']?.toString();
    if (json['data'] != null) {
      dataDetail = <CustomerModelData?>[];
      for (final v in json['data']) {
        dataDetail?.add(CustomerModelData.fromJson(v));
      }
    }
  }

  CustomerEntity toEntity() => CustomerEntity(
    code: statusCode,
    message: message,
    dataDetail: dataDetail?.map((e) => e?.toEntity()).toList(),
  );
}

class CustomerModelData {
  String? id;
  String? name;
  String? domicile;
  String? gender;

  CustomerModelData({this.id, this.name, this.domicile, this.gender});

  CustomerModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    domicile = json['domicile']?.toString();
    gender = json['gender']?.toString();
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name ?? '';
    data['domicile'] = domicile ?? '';
    data['gender'] = gender ?? '';
    return data;
  }

  CustomerEntityData toEntity() => CustomerEntityData(
    id: id,
    name: name,
    domicile: domicile,
    gender: gender,
  );
}
