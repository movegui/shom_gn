import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key,});

/*
  Future<void> _logout(BuildContext context) async {
    await authService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(authService: authService),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title:   Text('Dashboard'), //Text(l10n.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => (){}, //  _logout(context),
            tooltip: 'logout tooltip' // l10n.logoutTooltip,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Welcome userEmail', // l10n.welcomeUser(userEmail),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                 'Logged message', //  l10n.loggedInMessage,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flight_takeoff),
                label:  Text('search flight')  //Text(l10n.searchFlights),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.hotel),
                label:  Text('search Hotel') //Text(l10n.searchHotels),
              ),
            ],
          ),
        ),
      ),
    );
  }
}