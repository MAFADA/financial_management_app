// ignore: file_names
class Pengeluaran {
  // ignore: unused_field
  int? _id;
  late String _tanggal;
  late int _nominal;
  late String _keterangan;

  Pengeluaran(this._tanggal, this._nominal, this._keterangan);

  Pengeluaran.fromMap(dynamic obj) {
    _tanggal = obj['tanggal'];
    _nominal = obj['nominal'];
    _keterangan = obj['keterangan'];
  }

  String get tanggal => _tanggal;
  int get nominal => _nominal;
  String get keterangan => _keterangan;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["tanggal"] = _tanggal;
    map["nominal"] = _nominal;
    map["keterangan"] = _keterangan;
    return map;
  }
}
