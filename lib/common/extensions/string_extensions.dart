extension StringExtension on String {
  String intelliTrim() {
    return this.length > 15 ? '${this.substring(0, 15)}...' : this;
  }

  String commaAmount() {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';

    return '${this.replaceAllMapped(reg, mathFunc)}';
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
