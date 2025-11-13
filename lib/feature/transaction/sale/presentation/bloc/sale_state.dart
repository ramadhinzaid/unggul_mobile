import 'package:equatable/equatable.dart';
import 'package:unggul_mobile/core/util/error_entity.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/entity/sale_entity.dart';

class SaleState extends Equatable {
  final List<SaleEntityData?>? sales;
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const SaleState({this.error, this.isLoading, this.message, this.sales});

  @override
  List<Object?> get props => [error, isLoading, message, sales];

  SaleState copyWith({
    List<SaleEntityData?>? sales,
    String? message,
    bool? isLoading,
    ErrorEntity? error,
  }) => SaleState(
    error: error,
    isLoading: isLoading,
    message: message,
    sales: sales ?? this.sales,
  );
}

class SaleFormState extends Equatable {
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const SaleFormState({this.message, this.isLoading, this.error});
  @override
  List<Object?> get props => [message, isLoading, error];

  SaleFormState copyWith({
    String? message,
    ErrorEntity? error,
    bool? isLoading,
  }) => SaleFormState(message: message, error: error, isLoading: isLoading);
}
