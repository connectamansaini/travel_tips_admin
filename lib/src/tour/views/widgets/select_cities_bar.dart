import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tips_admin/src/cities/bloc/cities_bloc.dart';
import 'package:travel_tips_admin/src/cities/model/city.dart';
import 'package:travel_tips_admin/src/core/presentation/colors.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/views/widgets/cities_bottom_sheet.dart';

class SelectCitiesBar extends StatelessWidget {
  const SelectCitiesBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTourBloc, CreateTourState>(
      builder: (context, state) {
        return Wrap(
          runSpacing: 8,
          spacing: 8,
          children: [
            ...List.generate(
              state.tour.cities.length,
              (index) {
                final city = state.tour.cities[index];
                return Card(
                  margin: EdgeInsets.zero,
                  shape: const StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(city),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            context
                                .read<CreateTourBloc>()
                                .add(CityRemoved(city));
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet<City>(
                  context: context,
                  builder: (_) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<CitiesBloc>(),
                        ),
                        BlocProvider.value(
                          value: context.read<CreateTourBloc>(),
                        ),
                      ],
                      child: const CitiesBottomSheet(),
                    );
                  },
                );
              },
              child: Card(
                margin: EdgeInsets.zero,
                color: AppColors.primaryColorLight,
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Add City'),
                      SizedBox(width: 4),
                      Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
