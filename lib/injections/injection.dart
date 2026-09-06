import 'package:get_it/get_it.dart';
import 'package:finskool/injections/injection.config.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@injectableInit
void configureDependencies() => locator.init();
