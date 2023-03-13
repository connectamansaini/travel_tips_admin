import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tips_admin/src/cities/bloc/cities_bloc.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';

class CitiesBottomSheet extends StatelessWidget {
  const CitiesBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Select Tour Cities',
                ),
                onChanged: (value) {
                  context.read<CitiesBloc>().add(CitySearched(value));
                },
              ),
            ),
            Flexible(
              child: BlocBuilder<CitiesBloc, CitiesState>(
                builder: (context, state) {
                  if (state.searchedCities.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.searchedCities.length,
                      itemBuilder: (context, index) {
                        final city = state.searchedCities[index];
                        return ListTile(
                          title: Text(city.name),
                          onTap: () {
                            context
                                .read<CreateTourBloc>()
                                .add(CityAdded(city.name));
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  return ListView.builder(
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      final city = state.cities[index];
                      return ListTile(
                        title: Text(city.name),
                        onTap: () {
                          context
                              .read<CreateTourBloc>()
                              .add(CityAdded(city.name));
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
