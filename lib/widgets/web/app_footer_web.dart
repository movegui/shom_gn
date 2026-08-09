import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/services/config_service.dart';
import 'package:shom_gn/widgets/title_text.dart';


class AppFooterWeb extends StatelessWidget {
  const AppFooterWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFooterConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    final footerObj = snapshot.data!;
        return BottomAppBar(
          height: 100,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label: AppLocalizations.of(context)!.company_adresse_label,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(                      
                        footerObj.address,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label:  AppLocalizations.of(context)!.company_label_email,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(                     
                      footerObj.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label: AppLocalizations.of(context)!.company_label_phone,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(
                       footerObj.phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  
}


/*
import 'package:flutter/material.dart';

class ShomFooter extends StatelessWidget {
  const ShomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: const Color(0xff0F172A),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 40,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 800;

              return isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _sections(theme),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: _sections(theme),
                    );
            },
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          Text(
            '© 2026 SHOM. Tous droits réservés.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _sections(ThemeData theme) {
    return [
      SizedBox(
        width: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.flight_takeoff,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'SHOM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Réservez vos vols facilement et en toute sécurité.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      _FooterSection(
        title: 'Navigation',
        items: const [
          'Accueil',
          'Rechercher un vol',
          'Mes réservations',
          'Destinations',
        ],
      ),

      const SizedBox(height: 20),

      _FooterSection(
        title: 'Support',
        items: const [
          'FAQ',
          'Contact',
          'Conditions générales',
          'Politique de confidentialité',
        ],
      ),

      const SizedBox(height: 20),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suivez-nous',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),

          Row(
            children: const [
              _SocialButton(
                icon: Icons.facebook,
              ),
              SizedBox(width: 10),
              _SocialButton(
                icon: Icons.camera_alt,
              ),
              SizedBox(width: 10),
              _SocialButton(
                icon: Icons.business,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Row(
            children: [
              Icon(
                Icons.phone,
                color: Colors.white70,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                '+224 XXX XX XX XX',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              Icon(
                Icons.email,
                color: Colors.white70,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'contact@shom.gn',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}

class _FooterSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;

  const _SocialButton({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
*/