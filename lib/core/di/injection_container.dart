part of '../core.dart';

/// [GetIt] is a service locator.
final sl = GetIt.instance;

/// [initDependencyInjection] initializes the dependency injection.
Future<void> initDependencyInjection() async {
  sl
    // External
    ..registerLazySingleton<AppRouter>(AppRouter.new)
    ..registerLazySingleton<AppDatabase>(AppDatabase.new)
    ..registerLazySingleton<LocalDatasource>(
      () => LocalDatasourceImpl(sl()),
    );

  // Theme init dependency.
  _initTheme();

  // Transactions init dependency.
  _initTransactions();
}

void _initTheme() {
  sl
    ..registerLazySingleton<AppTheme>(() => AppTheme(sl()))
    ..registerLazySingleton<AppColorsLight>(AppColorsLight.new);
}

void _initTransactions() {
  sl
    // Bloc.
    ..registerLazySingleton<TransactionBloc>(
      () => TransactionBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerLazySingleton<FiltersBloc>(FiltersBloc.new)
    ..registerFactory(FormCubit.new)

    // Use cases.
    ..registerLazySingleton<GetTransactions>(() => GetTransactions(sl()))
    ..registerLazySingleton<CreateTransaction>(() => CreateTransaction(sl()))
    ..registerLazySingleton<UpdateTransaction>(() => UpdateTransaction(sl()))
    ..registerLazySingleton<DeleteTransaction>(() => DeleteTransaction(sl()))
    ..registerLazySingleton<GetFilteredTransactions>(
      () => GetFilteredTransactions(sl()),
    )

    // Repositories.
    ..registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(sl()),
    );
}
