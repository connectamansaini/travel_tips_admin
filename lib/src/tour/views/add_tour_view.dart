import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tips_admin/src/core/domain/enums.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/core/domain/validators.dart';
import 'package:travel_tips_admin/src/core/presentation/widgets/spacing.dart';
import 'package:travel_tips_admin/src/image_picker/bloc/image_picker_bloc.dart';
import 'package:travel_tips_admin/src/permission/bloc/permission_bloc.dart';
import 'package:travel_tips_admin/src/permission/repository/permission_repository.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/blocs/tour/tour_bloc.dart';
import 'package:travel_tips_admin/src/tour/views/widgets/enter_itinerary.dart';
import 'package:travel_tips_admin/src/tour/views/widgets/select_cities_bar.dart';
import 'package:travel_tips_admin/src/tour/views/widgets/upload_widget_card.dart';

class AddTourView extends StatefulWidget {
  const AddTourView({super.key});

  @override
  State<AddTourView> createState() => _AddTourViewState();
}

class _AddTourViewState extends State<AddTourView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cityController;
  late TextEditingController dayItineraryController;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    dayItineraryController = TextEditingController();
  }

  @override
  void dispose() {
    cityController.dispose();
    dayItineraryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PermissionBloc, PermissionState>(
          listener: (context, state) {
            if (state.galleryPermissionStatus ==
                GalleryPermissionStatus.permanentlyDenied) {
              context.read<PermissionRepository>().openSetting();
            }
            //* Listener will only called if state is changed
            // It is not a stream it is only checking when
            // state is changed in the bloc
            if (state.galleryPermissionStatus ==
                GalleryPermissionStatus.granted) {
              context.read<ImagePickerBloc>().add(GalleryImagePicked());
            }
          },
        ),
        BlocListener<ImagePickerBloc, ImagePickerState>(
          listener: (context, state) {
            if (state.storagePhotoStatus == Status.success()) {
              if (state.pickedImage != null) {
                context.read<CreateTourBloc>().add(
                      ImageUploaded(
                        file: state.pickedImage!,
                      ),
                    );
              }
            }
          },
        ),
        BlocListener<CreateTourBloc, CreateTourState>(
          listenWhen: (previous, current) =>
              previous.tourUploadStatus != current.tourUploadStatus,
          listener: (context, state) {
            if (state.tourUploadStatus is StatusSuccess) {
              context.read<TourBloc>().add(TourAdded(state.tour));

              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tour Uploaded'),
                ),
              );

              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add tour Here'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const UploadImageCard(),
                const Spacing(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          context
                              .read<CreateTourBloc>()
                              .add(TitleChanged(value));
                        },
                        validator: emptyStringValidator,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Tour Title',
                        ),
                      ),
                      const Spacing(),
                      TextFormField(
                        onChanged: (value) {
                          context
                              .read<CreateTourBloc>()
                              .add(DescriptionChanged(value));
                        },
                        validator: emptyStringValidator,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Tour Description',
                        ),
                      ),
                      const Spacing(),
                      TextFormField(
                        onChanged: (value) {
                          context
                              .read<CreateTourBloc>()
                              .add(PriceChanged(double.parse(value)));
                        },
                        validator: emptyPriceValidator,
                        decoration: const InputDecoration(
                          labelText: 'Enter price',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacing(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Select Cities',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                const SelectCitiesBar(),
                const Spacing(size: SpacingSize.regular),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Add Itinerary',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                EnterItineraryBar(
                  dayItineraryController: dayItineraryController,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<CreateTourBloc, CreateTourState>(
          builder: (context, state) {
            return FloatingActionButton.extended(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    state.imageUploadStatus == Status.success() &&
                    state.tour.cities.isNotEmpty &&
                    state.tour.daysItinerary.isNotEmpty) {
                  context.read<CreateTourBloc>().add(DataUploaded());
                } else {
                  if (state.imageUploadStatus != Status.success()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add Photo'),
                      ),
                    );
                  } else if (state.tour.cities.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add City'),
                      ),
                    );
                  } else if (state.tour.daysItinerary.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add Itinerary'),
                      ),
                    );
                  } else {}
                }
              },
              label: const Text('Submit'),
            );
          },
        ),
      ),
    );
  }
}
