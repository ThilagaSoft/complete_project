class Country {
  final Flag flag;
  final CountryName name;
  final String cca2;

  Country({
    required this.flag,
    required this.name,
    required this.cca2,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flag: Flag.fromJson(json['flags']),
      name: CountryName.fromJson(json['name']),
      cca2: json['cca2'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flags': flag.toJson(),
      'name': name.toJson(),
      'cca2': cca2,
    };
  }
}
class Flag {
  final String png;
  final String svg;
  final String? alt;

  Flag({
    required this.png,
    required this.svg,
    this.alt,
  });

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      png: json['png'] ?? '',
      svg: json['svg'] ?? '',
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'png': png,
      'svg': svg,
      'alt': alt,
    };
  }
}
class CountryName {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  CountryName({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) {
    final native = (json['nativeName'] as Map<String, dynamic>?) ?? {};
    final parsedNative = {
      for (var key in native.keys)
        key: NativeName.fromJson(native[key])
    };

    return CountryName(
      common: json['common'] ?? '',
      official: json['official'] ?? '',
      nativeName: parsedNative,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
      'official': official,
      'nativeName': {
        for (var key in nativeName.keys) key: nativeName[key]!.toJson(),
      },
    };
  }
}
class NativeName {
  final String common;
  final String official;

  NativeName({
    required this.common,
    required this.official,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) {
    return NativeName(
      common: json['common'] ?? '',
      official: json['official'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
      'official': official,
    };
  }
}
