import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/di/injection_container.dart';
import 'package:tracker/core/presentation/router/app_router.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart';

/// [App] is a class.
/// That extends [StatelessWidget] and builds the app.
class App extends StatelessWidget {
  /// [App] constructor.
  const App({
    required this.appRouter,
    super.key,
  });

  /// [appRouter] is the [AppRouter] instance.
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TransactionBloc>()),
        BlocProvider(create: (_) => sl<FormCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
