import 'package:equatable/equatable.dart';
import 'package:unggul_mobile/core/util/util.dart';
import 'package:unggul_mobile/feature/master/customer/domain/entity/customer_entity.dart';

class CustomerState extends Equatable {
  final List<CustomerEntityData?>? customers;
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const CustomerState({
    this.customers,
    this.message,
    this.isLoading,
    this.error,
  });
  @override
  List<Object?> get props => [customers, message, isLoading, error];

  CustomerState copyWith({
    List<CustomerEntityData?>? customers,
    String? message,
    ErrorEntity? error,
    bool? isLoading,
  }) => CustomerState(
    customers: customers ?? this.customers,
    message: message,
    error: error,
    isLoading: isLoading,
  );
}

class CustomerFormState extends Equatable {
  final String? message;
  final bool? isLoading;
  final ErrorEntity? error;

  const CustomerFormState({this.message, this.isLoading, this.error});
  @override
  List<Object?> get props => [message, isLoading, error];

  CustomerFormState copyWith({
    String? message,
    ErrorEntity? error,
    bool? isLoading,
  }) => CustomerFormState(message: message, error: error, isLoading: isLoading);
}
