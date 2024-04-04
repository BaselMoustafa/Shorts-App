import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/core/network/firebase/cloud_storage_helper/cloud_storage_helper.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_helper.dart';
import 'package:shorts_app/core/network/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shorts_app/core/network/network_connection_info/network_connection_info.dart';
import 'package:shorts_app/dependancies/persons/data/repo_impl/persons_repo_impl.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/follow_person_usecase.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/get_my_person_usecase.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/serach_persons_usecase.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/update_my_person_usecase.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_or_remove_short_like_cubit/add_or_remove_short_like_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_comment_cubit/add_short_comment_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_view_cubit/add_short_short_view_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit.dart';
import 'package:shorts_app/dependancies/shorts/data/data_source/shorts_local_datasource.dart';
import 'package:shorts_app/dependancies/shorts/data/data_source/shorts_remote_data_source.dart';
import 'package:shorts_app/dependancies/shorts/data/repo_impl/shorts_repo_impl.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_or_remove_short_like_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_short_comment_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_short_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_short_view_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/get_home_shorts_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/get_profile_shorts_usecase.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/get_short_comments_usecsae.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit.dart';
import 'package:shorts_app/features/authantication/Data/authantication_data_source/authantication_local_data_source.dart';
import 'package:shorts_app/features/authantication/Data/authantication_data_source/authantication_remote_data_source.dart';
import 'package:shorts_app/features/authantication/Data/authantication_reposatory_impl/authantication_reposatory_impl.dart';
import 'package:shorts_app/features/authantication/Domain/authantication_repo/authantication_reposatory.dart';
import 'package:shorts_app/features/authantication/Domain/usecases/check_email_verification_usecse.dart';
import 'package:shorts_app/features/authantication/Domain/usecases/send_email_verification_usecase.dart';
import 'package:shorts_app/features/authantication/Domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:shorts_app/features/authantication/Domain/usecases/sign_in_with_google_usecase.dart';
import 'package:shorts_app/features/authantication/Domain/usecases/sign_up_with_email_and_password_usecase.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/google_authantication_cubit/google_authantication_cubit.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/follow_person_cubit/follow_person_cubit.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';
import 'package:shorts_app/features/search/search_persons_cubit/search_persons_cubit.dart';
import '../../dependancies/persons/data/data_source/persons_local_data_source.dart';
import '../../dependancies/persons/data/data_source/persons_remote_data_source.dart';
import '../../features/authantication/presentation/controllers/email_authantication_cubit/email_authantication_cubit.dart';
import '../network/hive/hive_helper.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    //===================================CUBITS==================================================
    //Authantication
    getIt.registerFactory(() => EmailAuthanticationCubit(
        signUpWithEmailAndPasswordUseCase: getIt(),
        signInWithEmailAndPasswordUseCase: getIt(),
        sendEmailVerificationUsecase: getIt(),
        checkEmailVerificationUsecase: getIt(),
      ),
    );
    getIt.registerFactory(() => GoogleAuthanticationCubit(signInWithGoogleUsecase: getIt()));
    //Persons
    getIt.registerFactory(() => GetMyPersonCubit(getMyPersonUseCase: getIt()));
    //Shorts
    getIt.registerFactory(() => AddOrRemoveShortLikeCubit(addOrRemoveShortLikeUsecase: getIt()));
    getIt.registerFactory(() => AddShortViewCubit(addShortViewUsecase: getIt()));
    getIt.registerFactory(() => AddShortCommentCubit(addShortCommentUsecase: getIt()));
    getIt.registerFactory(() => GetShortCommentsCubit(getShortCommentsUsecase: getIt()));
    //Home
    getIt.registerFactory(() => GetHomeShortsCubit(getHomeShortsUsecase: getIt()));
    //Add Short
    getIt.registerFactory(() => AddShortCubit(addShortUsecase: getIt()));
    //Profile
    getIt.registerFactory(() => FollowPersonCubit(followPersonUsecase: getIt()));
    getIt.registerFactory(() => UpdateMyPersonCubit(updateMyPersonUsecase: getIt()));
    getIt.registerFactory(() => GetProfileShortsCubit(getProfileShortsUsecase: getIt()));
    //Search
    getIt.registerFactory(() => SearchPersonsCubit(searchPersonsUseCase: getIt()));

    //===================================USECASES==================================================
    //Authantication
    getIt.registerLazySingleton(() => SignUpWithEmailAndPasswordUseCase(authanticationReposatory: getIt()));
    getIt.registerLazySingleton(() => SendEmailVerificationUsecase(authanticationReposatory: getIt()));
    getIt.registerLazySingleton(() => CheckEmailVerificationUsecase(authanticationReposatory: getIt()));
    getIt.registerLazySingleton(() => SignInWithGoogleUsecase(authanticationReposatory: getIt()));
    getIt.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(authanticationReposatory: getIt()));
    //PERSONS
    getIt.registerLazySingleton(() => GetMyPersonUseCase(personsRepo: getIt(),),);
    getIt.registerLazySingleton(() => UpdateMyPersonUseCase(personsRepo: getIt(),),);
    getIt.registerLazySingleton(() => FollowPersonUsecase(personsRepo: getIt(),),);
    getIt.registerLazySingleton(() => SearchPersonsUseCase(personsRepo: getIt(),),);
    //SHORTS
    getIt.registerLazySingleton(() => GetHomeShortsUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => GetProfileShortsUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => GetShortCommentsUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => AddShortUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => AddOrRemoveShortLikeUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => AddShortViewUsecase(shortsRepo: getIt(),),);
    getIt.registerLazySingleton(() => AddShortCommentUsecase(shortsRepo: getIt(),),);
   

    //===================================REPOSATORIES==================================================
    //Authantication
    getIt.registerLazySingleton<AuthanticationReposatory>(
      () =>AuthanticationReposatoryImpl(
        networkConnectionInfo: getIt(),
        authanticationLocalDataSource: getIt(),
        authanticationRemoteDataSource: getIt(),
      ),
    );
    //PERSONS
    getIt.registerLazySingleton<PersonsRepo>(
      () =>PersonssRepoImpl(
        networkConnectionInfo: getIt(),
        personsLocalDataSource: getIt(),
        personsRemoteDataSource: getIt(),
      ),
    );
    //SHORTS
    getIt.registerLazySingleton<ShortsRepo>(
      () =>ShortsRepoImpl(
        networkConnectionInfo: getIt(),
        shortsLocalDataSource: getIt(),
        shortsRemoteDataSource: getIt(),
      ),
    );

    //===================================DATA SOURCES==================================================
    ///AUTHANTICATION
    getIt.registerLazySingleton<AuthanticationLocalDataSource>(
      () => AuthanticationLocalDataSourceImpl(hiveHelper: getIt())
    );
    getIt.registerLazySingleton<AuthanticationRemoteDataSource>(
      () => AuthanticationRemoteDataSourceImpl(fireStoreHelper: getIt(),firebaseAuthHelper: getIt(),)
    );

    //PERSONS
    getIt.registerLazySingleton<PersonsLocalDataSource>(
      () => PersonsLocalDataSourceImpl(hiveHelper: getIt())
    );
    getIt.registerLazySingleton<PersonsRemoteDataSource>(
      () => PersonsRemoteDataSourceImpl(fireStoreHelper: getIt(),cloudStorageHelper: getIt())
    );

    //SHORTS
    getIt.registerLazySingleton<ShortsLocalDataSource>(
      () => ShortsLocalDataSourceImpl(hiveHelper: getIt())
    );
    getIt.registerLazySingleton<ShortsRemoteDataSource>(
      () => ShortsRemoteDataSourceImpl(personsRemoteDataSource: getIt(),fireStoreHelper: getIt(),cloudStorageHelper: getIt())
    );


    //===================================NETWORKING HELPERS==================================================
    getIt.registerLazySingleton<NetworkConnectionInfo>(()=> NetworkConnectionInfoImple(internetConnectionChecker: InternetConnectionChecker()));
    getIt.registerLazySingleton(()=>HiveHelper());
    getIt.registerLazySingleton(()=>FirebaseAuthHelper());
    getIt.registerLazySingleton(()=>FireStoreHelper());
    getIt.registerLazySingleton(()=>CloudStorageHelper());
  }
}
