// ignore: file_names
class Keuangan {
  // ignore: unused_field
  int? _id;
  late String _tanggal;
  late String _tipe;
  late int _nominal;
  late String _keterangan;

  Keuangan(this._tanggal, this._tipe, this._nominal, this._keterangan);

  Keuangan.fromMap(dynamic obj) {
    _tanggal = obj['tanggal'];
    _tipe = obj['tipe'];
    _nominal = obj['nominal'];
    _keterangan = obj['keterangan'];
  }

  String get tanggal => _tanggal;
  int get nominal => _nominal;
  String get keterangan => _keterangan;
  String get tipe => _tipe;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["tanggal"] = _tanggal;
    map["tipe"] = _tipe;
    map["nominal"] = _nominal;
    map["keterangan"] = _keterangan;
    return map;
  }
}
