/// Одна завершённая аренда в истории.
class RentalItem {
  const RentalItem({
    required this.address,
    required this.dateTime,
    required this.duration,
    required this.price,
  });

  final String address;

  /// Например «28 сентября · 14:20».
  final String dateTime;

  /// Например «37 минут».
  final String duration;

  /// Например «5 сом».
  final String price;
}