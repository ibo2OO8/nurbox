import 'package:flutter/widgets.dart';


class StationData {
  const StationData({
    this.name = 'Кофейня 42',
    this.address = 'Душанбе, ул. Рудаки, 42',
    this.hint = 'Справа от входа',
    this.workUntil = 'До 22:00',
    this.status = 'открыто',
    this.takeCount = '6',
    this.returnCount = '4',
    this.number = '№108',
    this.photos = const [],
  });

  static const partner = StationData();

  /// Обычная станция: одно большое фото.
  static const regular = StationData(
    name: 'Станция №108',
    hint: 'У входа в здание',
  );

  final String name;
  final String address;
  final String hint;
  final String workUntil;
  final String status;
  final String takeCount;
  final String returnCount;
  final String number;

  /// Фото станции. Пусто = серая заглушка.
  /// Пример: `[AssetImage('assets/cafe.png'), NetworkImage('https://...')]`
  final List<ImageProvider> photos;
}

/// Одна строка тарифа: «Первые 15 минут — 0 сом».
class TariffRow {
  const TariffRow(this.label, this.price);

  final String label;
  final String price;
}

/// Данные тарифа.
class TariffData {
  const TariffData({
    this.depositTitle = 'Залог',
    this.depositNote =
        'Замораживаем при начале аренды.\nВернём после возврата пауэрбанка.',
    this.depositPrice = '100 сом',
    this.rows = const [
      TariffRow('Первые 15 минут', '0 сом'),
      TariffRow('Ещё 1 час', '5 сом'),
      TariffRow('До конца суток', '60 сом'),
      TariffRow('Следующие сутки', '60 сом'),
    ],
    this.summary = 'Первые 15 минут — 0 сом · залог 100 сом',
  });

  static const standard = TariffData();

  final String depositTitle;
  final String depositNote;
  final String depositPrice;
  final List<TariffRow> rows;

  /// Короткая строка под статистикой на свёрнутой панели.
  final String summary;
}
