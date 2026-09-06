// import 'package:dio/dio.dart';
// import 'package:hellow_common_components/utilities/common_api_utils/dio_interceptor.dart';
// import 'package:hellow_service_api/hellow_service_api.dart';

// class BaseDataCenter {
//   static const String baseUrl = "https://hellow-base-wklceqbijq-ts.a.run.app/";

//   DefaultApi serviceApi = HellowServiceApi(
//       dio: Dio(
//         BaseOptions(
//           baseUrl: baseUrl,
//           connectTimeout: const Duration(minutes: 1),
//           receiveTimeout: const Duration(minutes: 1),
//           sendTimeout: const Duration(minutes: 1),
//         ),
//       ),
//       interceptors: [
//         DioAuthInterceptor(),
//       ]).getDefaultApi();
// }
