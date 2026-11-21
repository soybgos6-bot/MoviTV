String? formatRuntime(int? minutes) {
  if (minutes == null || minutes <= 0) return null;
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) return '$rest min';
  return rest == 0 ? '$hours h' : '$hours h $rest min';
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

String formatMoney(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final remaining = digits.length - i;
    buffer.write(digits[i]);
    if (remaining > 1 && remaining % 3 == 1) buffer.write('.');
  }
  return '\$$buffer';
}

String translateStatus(String status) {
  switch (status) {
    case 'Released':
      return 'Estrenada';
    case 'Post Production':
      return 'Postproducción';
    case 'In Production':
      return 'En producción';
    case 'Planned':
      return 'Planeada';
    case 'Rumored':
      return 'Rumoreada';
    case 'Canceled':
      return 'Cancelada';
    case 'Returning Series':
      return 'En emisión';
    case 'Ended':
      return 'Finalizada';
    case 'Pilot':
      return 'Piloto';
    default:
      return status;
  }
}
