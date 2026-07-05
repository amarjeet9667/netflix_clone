// lib/features/user/data/models/subscription_model.dart
import '../../domain/entities/subscription_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  const SubscriptionModel({
    required super.id,
    required super.plan,
    required super.monthlyPrice,
    required super.currency,
    required super.nextBillingDate,
    required super.isActive,
    required super.paymentMethodLast4,
  });

  /// Dummy subscription — Standard plan
  factory SubscriptionModel.dummy() {
    return SubscriptionModel(
      id: 'sub_001',
      plan: SubscriptionPlan.standard,
      monthlyPrice: 649.00,
      currency: '₹',
      nextBillingDate: DateTime.now().add(const Duration(days: 22)),
      isActive: true,
      paymentMethodLast4: '4242',
    );
  }

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      plan: SubscriptionPlan.values.firstWhere(
        (e) => e.name == json['plan'],
        orElse: () => SubscriptionPlan.standard,
      ),
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      currency: json['currency'] as String? ?? '₹',
      nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      paymentMethodLast4: json['paymentMethodLast4'] as String? ?? '****',
    );
  }
}
