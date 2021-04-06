import 'package:vadmin/constants.dart';
import 'package:vadmin/models/date_model.dart';

// class RowNote {
//   String item;
//   int count;
//   List items;

//   RowNote(this.item, this.count);

//   RowNote.fromList(this.items) {
//     this.item = items[0];
//     this.count = items[1];
//   }

//   double get rowBill => price[item] * count;
// }

// This model is for sales either concluded or currently active,
// the model has the following atributes:
// An optional String Id;
// An optional String strItems; # used in case of connection with a db that stores strings
// a Date

class Sale {
  // TODO Add a note propertie<String>
  // TODO Add named constructor that allows create a sale from other sale
  String optStrId;
  String strItems;
  Date date;
  List<List> items;
  int folio;
  String post;

  @override
  String toString() {
    return 'Items : ${items.toString()} \nDate : ${date.toString()}' +
        '\nFolio : ${folio.toString()} \n Post : $post \n OptStr : $optStrId';
  }

  Sale([this.items, this.date, this.folio, this.post]) {
    this.items ??= List<List>();
    this.date ??= Date();
    this.post ??= '';
  }

  Sale.fromDate(this.date, [this.items, this.folio = 1, this.post]) {
    this.items ??= List<List>();
  }

  List<List> _parseItems(String _content) {
    List<List> _items = List<List>();
    String _preItems1 =
        _content.replaceAll('[[', '').replaceAll(']]', '').replaceAll(' ', '');
    List<String> _preItems2 = _preItems1.split('],[');
    _preItems2.forEach((e) {
      List _ls = e.split(',');
      _items.add([_ls[0], double.parse(_ls[1])]);
    });
    return _items;
  }

  int _parsefolio(String _prefolio) {
    return int.parse(_prefolio.split('_')[1].replaceAll('M', ''));
  }

  Sale.fromStr(Map details, String strId) {
    this.items = _parseItems(details['items']);
    this.post = details['post'];
    this.folio = _parsefolio(strId);
    this.date = Date.fromString(strId.split('_')[0].replaceAll(',', '.'));
  }

  String _strId() {
    return date.time.replaceAll('.', ',') + "_M${this.folio.toString()}";
  }

  double _bill() {
    double _total = 0;
    if (items.isEmpty) {
      return _total;
    } else {
      items.forEach((e) {
        _total += (price[e[0]] * e[1]);
      });
      return _total;
    }
  }

  String _hourfolio() {
    return date.time.split(' ')[1].split('.')[0] + ' Folio ${this.folio}';
  }

  double get bill => _bill();
  String get hourfolio => _hourfolio();
  String get billStr => _bill().toStringAsFixed(2);
  String get strId => _strId();
  String get ymd => this.date.ymd;
  String get ym => this.date.ym;
  void minusAt(int n, int x) => this.items[n][1] -= x;
  void plusAt(int n, int x) => this.items[n][1] += x;

  double countAt(int n) {
    return this.items[n][1].toDouble();
  }

  String countMoney(int n) {
    double _pre = this.items[n][1].toDouble();
    if (this.items[n][0] == 'Ropa') {
      double pre = _pre / 10;
      return pre.toStringAsFixed(1);
    } else {
      return _pre.toStringAsFixed(0);
    }
  }

  String countPriceAt(int n) {
    double _pre = price[this.items[n][0]] * this.items[n][1].toDouble();
    return _pre.toStringAsFixed(1);
  }

  // void get folioAdd => this.folio++;
  // void get folioMin => this.folio--;

  void add(String item, int count) {
    this.items.add([item, count]);
  }

  void setFolium(int f) {
    this.folio = f;
  }

  void setPost(String nPost) {
    this.post = nPost;
  }

  void removeAt(int n) {
    this.items.removeAt(n);
  }
}
