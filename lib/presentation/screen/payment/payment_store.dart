import 'package:flutter/foundation.dart';

enum PaymentMethodType { card, wallet }

/// Простое in-memory хранилище способов оплаты.
/// TODO: заменить на ваш state management / API.
class PaymentStore extends ChangeNotifier {
  PaymentStore._();
  static final PaymentStore instance = PaymentStore._();

  String? cardLast4 = '4242'; // как в макете; поставьте null, если карты нет
  String? walletPhone; // например "+992 90 123 45 67"
  PaymentMethodType? selected = PaymentMethodType.card;

  /// true, пока карта выбрана для текущей аренды (удалять нельзя).
  /// Выставляйте из логики аренды.
  bool cardInUse = false;

  void saveCard(String last4) {
    cardLast4 = last4;
    selected = PaymentMethodType.card;
    notifyListeners();
  }

  void removeCard() {
    cardLast4 = null;
    if (selected == PaymentMethodType.card) {
      selected = walletPhone != null ? PaymentMethodType.wallet : null;
    }
    notifyListeners();
  }

  void linkWallet(String phone) {
    walletPhone = phone;
    selected = PaymentMethodType.wallet;
    notifyListeners();
  }

  void select(PaymentMethodType type) {
    selected = type;
    notifyListeners();
  }
}
