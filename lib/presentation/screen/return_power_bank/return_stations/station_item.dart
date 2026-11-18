/// Одна станция в списке «Куда вернуть».
class StationItem {
  const StationItem({
    required this.name,
    required this.details,
    required this.status,
    this.available = true,
  });

  /// Например «Рудаки, 42».
  final String name;

  /// Например «№ 108 · 120 м».
  final String details;

  /// Например «4 ячейки свободны · 2 занятые».
  final String status;

  /// false — свободных ячеек нет, станцию нельзя выбрать.
  final bool available;
}
