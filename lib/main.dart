import 'package:flaviourfleet/repo/khalti_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "./app/app.dart";
import 'bloc/add_product_bloc/add_product_bloc.dart';
import 'bloc/fetch_product_bloc/fetch_product_bloc.dart';
import 'bloc/khalti_bloc/khalit_bloc.dart';
import 'core/networking/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();

  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FetchProductBloc(),
          ),
          BlocProvider(
            create: (context) =>
                KhaltiBloc(khaltiRepository: KhaltiRepository()),
          ),
          BlocProvider(
            create: (context) => AddProductBloc(),
          ),
        ],
        child: App(),
      ),
    ),
  );
}
