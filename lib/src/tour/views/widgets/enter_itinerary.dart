import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tips_admin/src/core/presentation/colors.dart';
import 'package:travel_tips_admin/src/core/presentation/constants.dart';
import 'package:travel_tips_admin/src/core/presentation/widgets/spacing.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';

class EnterItineraryBar extends StatelessWidget {
  const EnterItineraryBar({
    required this.dayItineraryController,
    super.key,
  });

  final TextEditingController dayItineraryController;

  @override
  Widget build(BuildContext context) {
    //? Is this day initialization is good?
    var day = 1;
    return BlocBuilder<CreateTourBloc, CreateTourState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              state.tour.daysItinerary.length,
              (index) {
                final dayItinerary = state.tour.daysItinerary[index];
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: Constants.baseMargin,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Day ${index + 1}: $dayItinerary',
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            context
                                .read<CreateTourBloc>()
                                .add(DayItineraryRemoved(dayItinerary));
                            day = day - 1;
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
                FocusManager.instance.primaryFocus?.unfocus();
                showModalBottomSheet<void>(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<CreateTourBloc>(),
                      child: BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Enter Itinerary for Day: $day',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        day = day + 1;
                                        context.read<CreateTourBloc>().add(
                                              DayItineraryAdded(
                                                dayItineraryController.text,
                                              ),
                                            );
                                        dayItineraryController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.check),
                                      label: const Text('Done'),
                                    ),
                                  ],
                                ),
                                const Spacing(
                                  size: SpacingSize.regular,
                                ),
                                TextField(
                                  maxLength: 200,
                                  controller: dayItineraryController,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // hintText: 'Enter Itinerary',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
                      Text('Add itinerary'),
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
