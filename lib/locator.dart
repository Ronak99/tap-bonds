import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_bonds/locator.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void setupLocator() => locator.init();
