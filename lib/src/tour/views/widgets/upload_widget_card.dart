import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/image_picker/bloc/image_picker_bloc.dart';
import 'package:travel_tips_admin/src/permission/bloc/permission_bloc.dart';
import 'package:travel_tips_admin/src/tour/blocs/create_tour/create_tour_bloc.dart';

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTourBloc, CreateTourState>(
      builder: (context, state) {
        if (state.imageUploadStatus == Status.success()) {
          return Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 30.h,
                  width: 50.w,
                  child: Image.network(
                    state.tour.titleImageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(GalleryImagePicked());
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ],
          );
        }
        if (state.imageUploadStatus == Status.loading()) {
          return SizedBox(
            height: 30.h,
            width: 50.w,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return SizedBox(
          height: 30.h,
          width: 50.w,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Upload photo'),
            onPressed: () {
              context.read<PermissionBloc>().add(GalleryPermissionRequested());
            },
          ),
        );
      },
    );
  }
}
