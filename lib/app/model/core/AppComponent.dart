import 'package:flutter/material.dart';
import 'package:invizi_network_mobile/app/model/core/AppProvider.dart';
import 'package:invizi_network_mobile/app/model/core/AppStoreApplication.dart';
import 'package:invizi_network_mobile/config/Env.dart';
import 'package:invizi_network_mobile/generated/i18n.dart';
import 'package:invizi_network_mobile/utility/log/Log.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class AppComponent extends StatefulWidget {

  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  State createState() {
    return new AppComponentState(_application);
  }
}

class AppComponentState extends State<AppComponent> {

  final AppStoreApplication _application;

  AppComponentState(this._application);

  @override
  void dispose()async{
    Log.info('dispose');
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {

    final app = new MaterialApp(
        title: Env.value.appName,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _application.router.generator,
    );
    print('initial core.route = ${app.initialRoute}');

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}