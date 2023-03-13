import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tips_admin/src/cities/bloc/cities_bloc.dart';
import 'package:travel_tips_admin/src/cities/repository/cities_repository.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/blocs/tour/tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/repository/tour_repository.dart';
import 'package:travel_tips_admin/src/tour/views/add_tour_view.dart';
import 'package:travel_tips_admin/src/tour/views/detail_tour_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Tips Admin'),
      ),
      body: BlocBuilder<TourBloc, TourState>(
        builder: (context, state) {
          if (state.toursStatus is StatusSuccess) {
            if (state.tours.isEmpty) {
              return const Center(
                child: Text('There are no entries in database'),
              );
            }
            return ListView.builder(
              itemCount: state.tours.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.tours[index].title),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<TourBloc>()
                            .add(TourDeleted(state.tours[index]));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailTourView(tour: state.tours[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          if (state.toursStatus is StatusFailure) {
            return const Center(child: Text('Failure'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        CreateTourBloc(context.read<TourRepository>())
                          ..add(TourIdCreated()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        CitiesBloc(context.read<CitiesRepository>())
                          ..add(CitiesRequested()),
                  ),
                ],
                child: const AddTourView(),
              ),
            ),
          );
        },
        label: const Text('Add Tour'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
