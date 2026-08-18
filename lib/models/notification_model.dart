import 'package:shom_gn/models/model.dart';

class NotificationModel extends Model {
  final String title;
  final String message;
  final bool isRead;
  final NotificationType type;

  NotificationModel({
    required this.title,
    required this.message,
    this.isRead = false,
    required this.type,
    required super.id,
    required super.name,
    required super.createdAt,
  });
}

enum NotificationType { booking, payment, promotion, system }
