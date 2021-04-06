class Date {
  String strDate;
  DateTime dateTime;

  @override
  String toString() {
    return this.dateTime.toString();
  }

  Date({this.dateTime}) {
    this.dateTime ??= DateTime.now();
  }

  Date.fromFirebase(strDate) : this(dateTime: parseDateWInfo(strDate));

  Date.fromString(strDate) : this(dateTime: DateTime.parse(strDate));

  Date.fromMonth(strYearMonth)
      : this(dateTime: DateTime.parse(strYearMonth + '-01 12:00:00.250000'));

  Date.fromDay(strYearMonthDay, Date now)
      : this(dateTime: DateTime.parse(strYearMonthDay + ' ' + now.onlyTime()));

  /// This method parses a datetime with an underscore used to add more info
  /// it also takes in account the ',' in the string, replacing the '.' to
  /// avoid confussion with the sub index notation for query purposes
  /// ex: `2020-10-27 00:47:52,043776_M2`

  static DateTime parseDateWInfo(String _preDate) {
    return DateTime.parse(_preDate.split('_')[0].replaceAll(',', '.'));
  }

  String onlyTime() {
    return this.dateTime.toString().split(' ')[1];
  }

  String timeWO(Date date) {
    return this._ymd() + ' ' + date.onlyTime();
  }

  // Returns the current year-month
  // ex: 2020-09

  String _yearMonth() {
    List<String> _ymd = this.dateTime.toString().split(' ')[0].split('-');
    return _ymd[0] + '-' + _ymd[1];
  }

  // Returns the current year-month
  // ex: 2020-09-30

  String _ymd() {
    return this.dateTime.toString().split(' ')[0];
  }

  String _time() {
    return this.dateTime.toString();
  }

  String monthName() {
    return months[this.ym.split('-')[1]];
  }

  String dayName() {
    return doftWeek[this.dateTime.weekday];
  }

  String casualDate() {
    return this.dayName() +
        " " +
        this.ymd.split('-')[2] +
        " " +
        this.monthName() +
        " " +
        this.ymd.split('-')[0];
  }

  String get ym => _yearMonth();
  String get time => _time();
  String get ymd => _ymd();
  String get day => _time().split(' ')[0];

  static Map<String, String> months = {
    '01': "Enero",
    '02': "Febrero",
    '03': "Marzo",
    '04': "Abril",
    '05': "Mayo",
    '06': "Junio",
    '07': "Julio",
    '08': "Agosto",
    '09': "Septiembre",
    '10': "Octubre",
    '11': "Noviembre",
    '12': "Diciembre"
  };

  static Map<int, String> doftWeek = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miercoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo'
  };
}
