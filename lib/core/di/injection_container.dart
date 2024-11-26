import 'package:get_it/get_it.dart';
import 'package:tracker/core/data/datasources/local/local_datasource.dart';
import 'package:tracker/core/data/datasources/local/local_datasource_impl.dart';
import 'package:tracker/core/database/app_database.dart';
import 'package:tracker/core/presentation/router/app_router.dart';
import 'package:tracker/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:tracker/features/transaction/domain/usecases/create_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/get_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/update_transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart';

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

  // Transactions init dependency.
  _initTransactions();
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
      ),
    )
    ..registerFactory(FormCubit.new)

    // Use cases.
    ..registerLazySingleton<GetTransactions>(() => GetTransactions(sl()))
    ..registerLazySingleton<CreateTransaction>(() => CreateTransaction(sl()))
    ..registerLazySingleton<UpdateTransaction>(() => UpdateTransaction(sl()))
    ..registerLazySingleton<DeleteTransaction>(() => DeleteTransaction(sl()))

    // Repositories.
    ..registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(sl()),
    );
}
