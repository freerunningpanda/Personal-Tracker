import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tracker/core/core.dart';
import 'package:tracker/core/presentation/router/app_router.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart';
import 'package:tracker/generated/l10n.dart';

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
        BlocProvider(create: (_) => sl<AnalysisBloc>()),
        BlocProvider(create: (_) => sl<FiltersBloc>()),
        BlocProvider(create: (_) => sl<FormCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
