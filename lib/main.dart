library panoramax;

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panoramax_mobile/service/api/model/geo_visio.dart';
import 'package:panoramax_mobile/service/api/model/geo_visio_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badges;
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:native_exif/native_exif.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
import 'package:sensors/sensors.dart';
import 'component/loader.dart';
import 'service/api/api.dart';
import 'constant.dart';

part 'component/app_bar.dart';
part 'component/collection_preview.dart';
part 'page/homepage.dart';
part 'page/capture_page.dart';
part 'page/collection_creation_page.dart';
part 'page/instance_page.dart';
part 'page/upload_pictures_page.dart';
part 'service/routing.dart';
part 'service/permission_helper.dart';
part 'utils/gravity_orientation_detector.dart';

const String DATE_FORMATTER = 'dd/MM - HH:mm';

void main() {
  GetIt.instance
      .registerLazySingleton<NavigationService>(() => NavigationService());
  runApp(const PanoramaxApp());
}

class PanoramaxApp extends StatelessWidget {
  final String? selectedLocale;

  const PanoramaxApp({super.key, this.selectedLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Panoramax',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: DEFAULT_COLOR),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: getSupportedLocales,
        initialRoute: Routes.homepage,
        onGenerateRoute: generateRoutes,
        navigatorKey: GetIt.instance<NavigationService>().navigatorkey);
  }

  List<Locale> get getSupportedLocales {
    return this.selectedLocale != null
        ? [
            Locale(selectedLocale!),
          ]
        : const [
            Locale('en'),
            Locale('fr'),
          ];
  }
}
