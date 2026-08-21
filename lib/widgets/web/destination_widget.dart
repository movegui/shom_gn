import 'package:flutter/material.dart';
import 'package:shom_gn/models/destination_model.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/util/destination_card.dart';

class DestinationWidget extends StatelessWidget {
  const DestinationWidget({super.key, required this.destinations});
  final  List<DestinationModel> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemsPerRow = Responsive.isDesktop(context)
            ? 4
            : 2 // (constraints.maxWidth / 250)
                  .floor()
                  .clamp(1, 6);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemsPerRow,
              crossAxisSpacing: 12,
              mainAxisSpacing: 6,
              childAspectRatio: 1,
               mainAxisExtent:Responsive.isDesktop(context) ? 280 : 200,
            ),

            itemCount: destinations.length,

            itemBuilder: (context, index) {
              return DestinationCard(
                city: destinations[index].city,
                price: destinations[index].price,
                imageUrl: destinations[index].imageUrl ?? '',
                onTap: () {},
              );
            },
          ),
        );
      },
    );

    /*
    return SizedBox(
      width: 1200,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: const [

          DestinationCard(
            city: "Paris",
            price:399,
             imageUrl: '' ,
             color: Colors.green,
             
          ),

          DestinationCard(
            city: "Dubai",
            price: 299 , 
            imageUrl: '',
          ),

          DestinationCard(
            city: "Londres",
            price: 349, 
            imageUrl: '',
          ),
        ],
      ),
    );
    */
  }
}
