import 'package:equatable/equatable.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/stock/domain/entity/stock_entity.dart';

class StockState extends Equatable {
  final List<StockEntityData?>? stocks;
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const StockState({this.stocks, this.message, this.isLoading, this.error});
  @override
  List<Object?> get props => [stocks, message, isLoading, error];

  StockState copyWith({
    List<StockEntityData?>? stocks,
    String? message,
    ErrorEntity? error,
    bool? isLoading,
  }) => StockState(
    stocks: stocks ?? this.stocks,
    message: message,
    error: error,
    isLoading: isLoading,
  );
}

class StockFormState extends Equatable {
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const StockFormState({this.message, this.isLoading, this.error});
  @override
  List<Object?> get props => [message, isLoading, error];

  StockFormState copyWith({
    String? message,
    ErrorEntity? error,
    bool? isLoading,
  }) => StockFormState(message: message, error: error, isLoading: isLoading);
}
