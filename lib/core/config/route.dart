import 'package:go_router/go_router.dart';
import 'package:unggul_mobile/core/components/template/main_layout.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/page/customer_form_page.dart';
import 'package:unggul_mobile/feature/master/customer/presentation/page/customer_page.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/page/stock_form_page.dart';
import 'package:unggul_mobile/feature/master/stock/presentation/page/stock_page.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/page/sale_form_page.dart';
import 'package:unggul_mobile/feature/transaction/sale/presentation/page/sale_page.dart';

final routeConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainLayout(),
      routes: [
        GoRoute(
          path: '/sales',
          builder: (context, state) => SalePage(),
          routes: [
            GoRoute(
              path: '/create',
              builder: (context, state) => SaleFormPage(),
            ),
            GoRoute(
              path: '/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return SaleFormPage(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/customers',
          builder: (context, state) => CustomerPage(),
          routes: [
            GoRoute(
              path: '/create',
              builder: (context, state) => CustomerFormPage(),
            ),
            GoRoute(
              path: '/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return CustomerFormPage(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/stocks',
          builder: (context, state) => StockPage(),
          routes: [
            GoRoute(
              path: '/create',
              builder: (context, state) => StockFormPage(),
            ),
            GoRoute(
              path: '/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return StockFormPage(id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
