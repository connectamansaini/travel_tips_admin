import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_tips_admin/src/cities/repository/cities_repository.dart';
import 'package:travel_tips_admin/src/home/views/home_view.dart';
import 'package:travel_tips_admin/src/image_picker/bloc/image_picker_bloc.dart';
import 'package:travel_tips_admin/src/image_picker/repository/image_picker_repository.dart';
import 'package:travel_tips_admin/src/permission/bloc/permission_bloc.dart';
import 'package:travel_tips_admin/src/permission/repository/permission_repository.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/blocs/tour/tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/repository/tour_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ImagePickerRepository(),
        ),
        RepositoryProvider(
          create: (context) => TourRepository(),
        ),
        RepositoryProvider(
          create: (context) => PermissionRepository(),
        ),
        RepositoryProvider(
          create: (context) => CitiesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ImagePickerBloc(context.read<ImagePickerRepository>()),
          ),
          //* Tour stored in firebase is requested here
          BlocProvider(
            create: (context) =>
                TourBloc(context.read<TourRepository>())..add(TourRequested()),
          ),
          BlocProvider(
            create: (context) => CreateTourBloc(context.read<TourRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                PermissionBloc(context.read<PermissionRepository>()),
          ),
        ],
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeView(),
            );
          },
        ),
      ),
    );
  }
}
