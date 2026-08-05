import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem  {
  const MenuItem({ 
    required this.title,
    //required this.subtitle
    required this.route,
   });
   final String title;
   final String route;
}


class FooterItem extends StatelessWidget{
  const FooterItem({super.key, 
    required this.title,
    //required this.subtitle
    required this.route,
   });
   final String title;
   final String route;
   

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(route);
      },
       child: Card(
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(title: Text(title)),
        ),
      ),
    );
  }
}