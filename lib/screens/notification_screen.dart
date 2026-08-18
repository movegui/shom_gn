import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/notification_model.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';
import 'package:uuid/uuid.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationModel> notifications = [];

  @override
  void initState() {
    notifications = [
      NotificationModel(
        title: "Réservation confirmée",
        message: "Votre vol Conakry → Paris a été confirmé.",
        createdAt: DateTime.now(),
        type: NotificationType.booking,
        id: Uuid().v4(),
        name: '',
      ),
      NotificationModel(
        title: "Paiement reçu",
        message: "Le paiement de 399 € a été validé.",
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.payment,
        id: Uuid().v4(),
        name: '',
      ),
      NotificationModel(
        title: "Nouvelle promotion",
        message: "Profitez de 20% de réduction sur les vols vers Dubai.",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.promotion,
        isRead: true,
        id: Uuid().v4(),
        name: '',
      ),
    ];
    super.initState();
  }

  IconData _icon(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Icons.flight_takeoff;

      case NotificationType.payment:
        return Icons.payment;

      case NotificationType.promotion:
        return Icons.local_offer;

      case NotificationType.system:
        return Icons.notifications;
    }
  }

  Color _color(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Colors.blue;

      case NotificationType.payment:
        return Colors.green;

      case NotificationType.promotion:
        return Colors.orange;

      case NotificationType.system:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [TextButton(onPressed: () {}, child: const Text("Tout lire"))],
      ),
      */
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                  onPressed: (item) async {},
                  buttonItem: ButtonInfo(
                    title: AppLocalizations.of(context)!.read_all,
                    enabled: false,
                  ),
                  textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: notif.isRead
                        ? Colors.white
                        : Colors.blue.withOpacity(.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: notif.isRead
                          ? AppColors
                                .disabled // Colors.grey.shade200
                          : AppColors
                                .notificationContainer, // Colors.blue.shade200,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: _color(notif.type).withOpacity(.1),
                        child: Icon(
                          _icon(notif.type),
                          color: _color(notif.type),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notif.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          fontWeight: notif.isRead
                                              ? FontWeight.w500
                                              : FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.primary,
                                        ),
                                  ),
                                ),

                                if (!notif.isRead)
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Text(
                              notif.message,
                              style: TextStyle(color: Colors.grey.shade700),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "${notif.createdAt.day}/${notif.createdAt.month}/${notif.createdAt.year}",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
