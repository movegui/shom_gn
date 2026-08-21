import 'package:flutter/material.dart';

class HeroWebSection extends StatelessWidget {
  const HeroWebSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1436491865332-7a61a109cc05",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            width: 1000,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text(
                  "Où souhaitez-vous voyager ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Départ",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Destination",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Date",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        label: const Text("Rechercher"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}