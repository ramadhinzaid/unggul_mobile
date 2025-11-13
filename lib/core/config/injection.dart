import 'package:get_it/get_it.dart';
import 'package:unggul_mobile/core/config/config.dart';
import 'package:unggul_mobile/feature/master/customer/data/repositories/customer_repository_impl.dart';
import 'package:unggul_mobile/feature/master/customer/data/source/customer_remote_source.dart';
import 'package:unggul_mobile/feature/master/customer/domain/repository/customer_repository.dart';
import 'package:unggul_mobile/feature/master/customer/domain/usecase/customer_fetch_usecase.dart';
import 'package:unggul_mobile/feature/master/customer/domain/usecase/customer_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_form_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/data/repositories/stock_repository_impl.dart';
import 'package:unggul_mobile/feature/master/stock/data/source/stock_remote_source.dart';
import 'package:unggul_mobile/feature/master/stock/domain/repository/stock_repository.dart';
import 'package:unggul_mobile/feature/master/stock/domain/usecase/stock_fetch_usecase.dart';
import 'package:unggul_mobile/feature/master/stock/domain/usecase/stock_manage_usecase.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_form_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/repositories/sale_repository_impl.dart';
import 'package:unggul_mobile/feature/transaction/sale/data/source/sale_remote_source.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/repository/sale_repository.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_fetch_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_item_fetch_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/domain/usecase/sale_manage_usecase.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_form_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<API>(() => API(baseURL));

  sl.registerFactory<SaleCubit>(
    () => SaleCubit(sl<SaleManageUsecase>(), sl<SaleFetchUsecase>()),
  );
  sl.registerFactory<SaleFormCubit>(
    () => SaleFormCubit(sl<SaleManageUsecase>()),
  );

  sl.registerFactory<CustomerCubit>(
    () =>
        CustomerCubit(sl<CustomerManageUsecase>(), sl<CustomerFetchUsecase>()),
  );
  sl.registerFactory<CustomerFormCubit>(
    () => CustomerFormCubit(sl<CustomerManageUsecase>()),
  );

  sl.registerFactory<StockCubit>(
    () => StockCubit(sl<StockManageUsecase>(), sl<StockFetchUsecase>()),
  );
  sl.registerFactory<StockFormCubit>(
    () => StockFormCubit(sl<StockManageUsecase>()),
  );

  // Transaction
  // Sale
  sl.registerLazySingleton<SaleRemoteSource>(
    () => SaleRemoteSourceImpl(sl<API>()),
  );
  sl.registerLazySingleton<SaleRepository>(
    () => SaleRepositoryImpl(sl<SaleRemoteSource>()),
  );
  sl.registerLazySingleton<SaleFetchUsecase>(
    () => SaleFetchUsecase(sl<SaleRepository>()),
  );
  sl.registerLazySingleton<SaleItemFetchUsecase>(
    () => SaleItemFetchUsecase(sl<SaleRepository>()),
  );
  sl.registerLazySingleton<SaleManageUsecase>(
    () => SaleManageUsecase(sl<SaleRepository>()),
  );

  // Customer
  sl.registerLazySingleton<CustomerRemoteSource>(
    () => CustomerRemoteSourceImpl(sl<API>()),
  );
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(sl<CustomerRemoteSource>()),
  );
  sl.registerLazySingleton<CustomerFetchUsecase>(
    () => CustomerFetchUsecase(sl<CustomerRepository>()),
  );
  sl.registerLazySingleton<CustomerManageUsecase>(
    () => CustomerManageUsecase(sl<CustomerRepository>()),
  );

  // Stock
  sl.registerLazySingleton<StockRemoteSource>(
    () => StockRemoteSourceImpl(sl<API>()),
  );
  sl.registerLazySingleton<StockRepository>(
    () => StockRepositoryImpl(sl<StockRemoteSource>()),
  );
  sl.registerLazySingleton<StockFetchUsecase>(
    () => StockFetchUsecase(sl<StockRepository>()),
  );
  sl.registerLazySingleton<StockManageUsecase>(
    () => StockManageUsecase(sl<StockRepository>()),
  );
}
