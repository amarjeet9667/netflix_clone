// lib/features/user/domain/entities/subscription_entity.dart
import 'package:equatable/equatable.dart';

enum SubscriptionPlan { mobile, basic, standard, premium }

class SubscriptionEntity extends Equatable {
  final String id;
  final SubscriptionPlan plan;
  final double monthlyPrice;
  final String currency;
  final DateTime nextBillingDate;
  final bool isActive;
  final String paymentMethodLast4;

  const SubscriptionEntity({
    required this.id,
    required this.plan,
    required this.monthlyPrice,
    required this.currency,
    required this.nextBillingDate,
    required this.isActive,
    required this.paymentMethodLast4,
  });

  String get planLabel {
    switch (plan) {
      case SubscriptionPlan.mobile:
        return 'Mobile';
      case SubscriptionPlan.basic:
        return 'Basic';
      case SubscriptionPlan.standard:
        return 'Standard';
      case SubscriptionPlan.premium:
        return 'Premium';
    }
  }

  String get priceLabel => '$currency${monthlyPrice.toStringAsFixed(2)}/month';

  @override
  List<Object?> get props => [
    id,
    plan,
    monthlyPrice,
    currency,
    nextBillingDate,
    isActive,
    paymentMethodLast4,
  ];
}
