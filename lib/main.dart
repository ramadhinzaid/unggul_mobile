import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unggul_mobile/core/config/config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_cubit.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/bloc/customer_form_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_cubit.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/bloc/stock_form_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_cubit.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/bloc/sale_form_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SaleCubit>()),
        BlocProvider(create: (context) => sl<SaleFormCubit>()),

        BlocProvider(create: (context) => sl<CustomerCubit>()),
        BlocProvider(create: (context) => sl<CustomerFormCubit>()),

        BlocProvider(create: (context) => sl<StockCubit>()),
        BlocProvider(create: (context) => sl<StockFormCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unggul Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      locale: Locale('id', 'ID'),
      supportedLocales: [Locale('en', 'US'), Locale('id', 'ID')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: routeConfig,
    );
  }
}
