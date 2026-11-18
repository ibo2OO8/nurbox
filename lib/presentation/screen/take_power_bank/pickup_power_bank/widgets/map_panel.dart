enum MapPanel {
  main(size: 0.35, label: 'Nurbox'),
  station(size: 0.48, label: 'Nurbox'),
  qrRead(size: 0.70, label: 'QR считан'),
  rental(size: 0.43, label: 'QR считан'),
  // Новые добавлены в конец, чтобы номера 0–3 не сдвинулись.
  returnStation(size: 0.37, label: 'Nurbox'),     // 4
  returnUnavailable(size: 0.36, label: 'Nurbox'), // 5
  returnChecking(size: 0.40, label: 'Nurbox');    // 6

  const MapPanel({required this.size, required this.label});

  final double size;
  final String label;

  bool get isReturn =>
      this == returnStation || this == returnUnavailable || this == returnChecking;
}