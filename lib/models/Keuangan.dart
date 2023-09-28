class Keuangan {
  int? _id;
  late String _tanggal;
  late String _tipe;
  late double _nominal;
  late String _keterangan;
  late int _user_id; // Add user_id property

  Keuangan(this._tanggal, this._tipe, this._nominal, this._keterangan, this._user_id); // Update constructor

  Keuangan.fromMap(dynamic obj) {
    _tanggal = obj['tanggal'];
    _tipe = obj['tipe'];
    _nominal = obj['nominal'];
    _keterangan = obj['keterangan'];
    _user_id = obj['user_id']; // Initialize user_id
  }

  String get tanggal => _tanggal;
  double get nominal => _nominal;
  String get keterangan => _keterangan;
  String get tipe => _tipe;
  int get user_id => _user_id; // Add getter for user_id

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["tanggal"] = _tanggal;
    map["tipe"] = _tipe;
    map["nominal"] = _nominal;
    map["keterangan"] = _keterangan;
    map["user_id"] = _user_id; // Include user_id in the map
    return map;
  }
}