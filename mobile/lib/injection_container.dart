import 'package:architect/features/architect/presentations/bloc/type/type_bloc.dart'
    as type;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/architect/data/datasources/local/auth.dart';
import 'features/architect/data/datasources/local/post.dart';
import 'features/architect/data/datasources/local/type.dart';
import 'features/architect/data/datasources/local/user.dart';
import 'features/architect/data/datasources/remote/auth.dart';
import 'features/architect/data/datasources/remote/chat.dart';
import 'features/architect/data/datasources/remote/download_image.dart';
import 'features/architect/data/datasources/remote/post.dart';
import 'features/architect/data/datasources/remote/user.dart';
import 'features/architect/data/repositories/auth.dart';
import 'features/architect/data/repositories/chat.dart';
import 'features/architect/data/repositories/post.dart';
import 'features/architect/data/repositories/type.dart';
import 'features/architect/data/repositories/user.dart';
import 'features/architect/domains/repositories/auth.dart';
import 'features/architect/domains/repositories/chat.dart';
import 'features/architect/domains/repositories/post.dart';
import 'features/architect/domains/repositories/type.dart';
import 'features/architect/domains/repositories/user.dart';
import 'features/architect/domains/use_cases/auth/get_token.dart';
import 'features/architect/domains/use_cases/auth/is_auth.dart';
import 'features/architect/domains/use_cases/chat/create.dart';
import 'features/architect/domains/use_cases/chat/message.dart';
import 'features/architect/domains/use_cases/chat/view.dart';
import 'features/architect/domains/use_cases/chat/views.dart';
import 'features/architect/domains/use_cases/post/all.dart';
import 'features/architect/domains/use_cases/post/views.dart';
import 'features/architect/domains/use_cases/type/get.dart';
import 'features/architect/domains/use_cases/type/set.dart';
import 'features/architect/domains/use_cases/user/create.dart';
import 'features/architect/domains/use_cases/user/delete.dart';
import 'features/architect/domains/use_cases/user/follow.dart';
import 'features/architect/domains/use_cases/user/followers.dart';
import 'features/architect/domains/use_cases/user/following.dart';
import 'features/architect/domains/use_cases/user/me.dart';
import 'features/architect/domains/use_cases/user/unfollow.dart';
import 'features/architect/domains/use_cases/user/update.dart';
import 'features/architect/domains/use_cases/user/view.dart';
import 'features/architect/presentations/bloc/auth/auth_bloc.dart';
import 'features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'features/architect/presentations/bloc/post/post_bloc.dart';
import 'features/architect/presentations/bloc/user/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // Type
  sl.registerFactory(() => type.TypeBloc(
        getType: sl(),
        setType: sl(),
      ));

  // Chat
  sl.registerFactory(() => ChatBloc(
        chatCreate: sl(),
        chatView: sl(),
        chatViews: sl(),
        chatMessage: sl(),
      ));

  // Post
  sl.registerFactory(() => PostBloc(
        allPosts: sl(),
        viewsPost: sl(),
      ));

  // User
  sl.registerFactory(() => UserBloc(
        createUser: sl(),
        deleteUser: sl(),
        getUser: sl(),
        getCurrentUser: sl(),
        updateUser: sl(),
        followUser: sl(),
        unfollowUser: sl(),
        followingUser: sl(),
        followersUser: sl(),
      ));

  // Auth
  sl.registerFactory(() => AuthBloc(
        checkAuth: sl(),
        getToken: sl(),
      ));

  // Use cases
  // Type
  sl.registerLazySingleton(() => SetType(sl()));
  sl.registerLazySingleton(() => GetType(sl()));

  // Chat
  sl.registerLazySingleton(() => CreateChat(sl()));
  sl.registerLazySingleton(() => ViewChat(sl()));
  sl.registerLazySingleton(() => ViewsChat(sl()));
  sl.registerLazySingleton(() => MakeChat(sl()));

  // Post
  sl.registerLazySingleton(() => AllPost(sl()));
  sl.registerLazySingleton(() => ViewsPost(sl()));

  // User
  sl.registerLazySingleton(() => UserCreate(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));
  sl.registerLazySingleton(() => FollowUser(sl()));
  sl.registerLazySingleton(() => UserFollowers(sl()));
  sl.registerLazySingleton(() => UserFollowing(sl()));
  sl.registerLazySingleton(() => UnFollowUser(sl()));
  sl.registerLazySingleton(() => UserUpdate(sl()));
  sl.registerLazySingleton(() => ViewUser(sl()));
  sl.registerLazySingleton(() => Me(sl()));

  // Auth
  sl.registerLazySingleton(() => GetToken(sl()));
  sl.registerLazySingleton(() => CheckAuth(sl()));

  // Repository
  // Type
  sl.registerLazySingleton<TypeRepository>(
    () => TypeRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Chat
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Post
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      authLocalDataSource: sl(),
      userRemoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // User
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
      authLocalDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  // Remote
  // Image
  sl.registerLazySingleton<GetImageRemoteDataSource>(
      () => GetImageRemoteDataSourceImpl(client: sl()));

  // Chat
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(client: sl()),
  );

  // Post
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));

  // User
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Local
  // Type
  sl.registerLazySingleton<TypeLocalDataSource>(
    () => TypeLocalDataSourceImpl(sl()),
  );

  // Post
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sl(), sl()));

  // User
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl(), sl()),
  );

  // Auth
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
