import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:striv/core/network/dio_client.dart';

// Auth
import 'package:striv/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:striv/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:striv/features/auth/domain/repositories/auth_repository.dart';
import 'package:striv/features/auth/domain/usecases/login_usecase.dart';
import 'package:striv/features/auth/domain/usecases/signup_usecase.dart';
import 'package:striv/features/auth/presentation/bloc/auth_bloc.dart';

// Navigation
import 'package:striv/features/navigation/cubit/navigation_cubit.dart';

// Home
import 'package:striv/features/home/data/datasources/home_local_data_source.dart';
import 'package:striv/features/home/data/repositories/home_repository_impl.dart';
import 'package:striv/features/home/domain/repositories/home_repository.dart';
import 'package:striv/features/home/domain/usecases/get_entrepreneur_home_usecase.dart';
import 'package:striv/features/home/domain/usecases/get_investor_home_usecase.dart';
import 'package:striv/features/home/presentation/bloc/home_bloc.dart';

// Discover
import 'package:striv/features/discover/data/datasources/discover_local_data_source.dart';
import 'package:striv/features/discover/data/repositories/discover_repository_impl.dart';
import 'package:striv/features/discover/domain/repositories/discover_repository.dart';
import 'package:striv/features/discover/domain/usecases/get_pitches_usecase.dart';
import 'package:striv/features/discover/presentation/bloc/discover_bloc.dart';

// Chat
import 'package:striv/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:striv/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:striv/features/chat/domain/repositories/chat_repository.dart';
import 'package:striv/features/chat/domain/usecases/chat_usecases.dart';
import 'package:striv/features/chat/presentation/bloc/chat_bloc.dart';

// Notifications
import 'package:striv/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:striv/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:striv/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:striv/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:striv/features/notifications/presentation/bloc/notifications_bloc.dart';

// Community
import 'package:striv/features/community/presentation/cubit/community_cubit.dart';

// Settings
import 'package:striv/features/settings/presentation/cubit/settings_cubit.dart';

// Pitch
import 'package:striv/features/pitch/presentation/bloc/pitch_upload_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ─── Network ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // ─── Auth ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerFactory(
      () => AuthBloc(loginUseCase: sl(), signupUseCase: sl()));

  // ─── Navigation ───────────────────────────────────────────────────────────
  sl.registerFactory(() => NavigationCubit());

  // ─── Home ─────────────────────────────────────────────────────────────────
  // Swap HomeLocalDataSourceImpl → HomeRemoteDataSourceImpl when backend ready
  sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetEntrepreneurPitchesUseCase(sl()));
  sl.registerLazySingleton(() => GetNewInvestorsUseCase(sl()));
  sl.registerLazySingleton(() => GetInvestorSmartMatchesUseCase(sl()));
  sl.registerFactory(() => HomeBloc(
        getEntrepreneurPitches: sl(),
        getNewInvestors: sl(),
        getInvestorSmartMatches: sl(),
      ));

  // ─── Discover ─────────────────────────────────────────────────────────────
  // Swap DiscoverLocalDataSourceImpl → DiscoverRemoteDataSourceImpl when ready
  sl.registerLazySingleton<DiscoverLocalDataSource>(
      () => DiscoverLocalDataSourceImpl());
  sl.registerLazySingleton<DiscoverRepository>(
      () => DiscoverRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetSwipeablePitchesUseCase(sl()));
  sl.registerLazySingleton(() => GetFeedPostsUseCase(sl()));
  sl.registerLazySingleton(() => GetReelsUseCase(sl()));
  sl.registerFactory(() => DiscoverBloc(
        getSwipeablePitches: sl(),
        getFeedPosts: sl(),
        getReels: sl(),
      ));

  // ─── Chat ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl());
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetContactsUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerFactory(
      () => ChatBloc(getContacts: sl(), getMessages: sl()));

  // ─── Notifications ────────────────────────────────────────────────────────
  sl.registerLazySingleton<NotificationsLocalDataSource>(
      () => NotificationsLocalDataSourceImpl());
  sl.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerFactory(
      () => NotificationsBloc(getNotifications: sl()));

  // ─── Community ────────────────────────────────────────────────────────────
  sl.registerFactory(() => CommunityCubit());

  // ─── Settings ─────────────────────────────────────────────────────────────
  sl.registerFactory(() => SettingsCubit());

  // ─── Pitch Upload ─────────────────────────────────────────────────────────
  sl.registerFactory(() => PitchUploadBloc());
}
