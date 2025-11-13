import 'package:unggul_mobile/feature/master/stock/data/model/stock_model.dart';

class SaleRequest {
  String? date;
  String? customerId;
  List<StockModelData?>? products;

  SaleRequest({this.date, this.customerId, this.products});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date ?? '';
    data['customer_id'] = customerId ?? '';
    if (products != null) {
      data['products'] = products?.map((v) => v?.toJsonSale()).toList();
    }
    return data;
  }
}
