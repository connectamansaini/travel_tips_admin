import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_tips_admin/src/tour/models/tour.dart';

class DetailTourView extends StatelessWidget {
  const DetailTourView({
    required this.tour,
    super.key,
  });
  final Tour tour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tour.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              height: 40.h,
              width: double.infinity,
              child: Image.network(
                tour.titleImageUrl,
                fit: BoxFit.fitHeight,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Name: ${tour.title}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Description: ${tour.description}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Wrap(
                  children: List.generate(
                    tour.cities.length,
                    (index) => Text('${tour.cities[index]} '),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Column(
                  children: List.generate(
                    tour.daysItinerary.length,
                    (index) => Text(
                      'Day ${index + 1}: ${tour.daysItinerary[index]}\n',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Price: ${tour.price.toInt()}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
