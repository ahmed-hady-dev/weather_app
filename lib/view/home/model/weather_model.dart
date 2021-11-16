class WeatherModelSys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  WeatherModelSys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  WeatherModelSys.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toInt();
    id = json['id']?.toInt();
    country = json['country']?.toString();
    sunrise = json['sunrise']?.toInt();
    sunset = json['sunset']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class WeatherModelClouds {
  int? all;

  WeatherModelClouds({
    this.all,
  });
  WeatherModelClouds.fromJson(Map<String, dynamic> json) {
    all = json['all']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class WeatherModelWind {
  double? speed;
  int? deg;

  WeatherModelWind({
    this.speed,
    this.deg,
  });
  WeatherModelWind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }
}

class WeatherModelMain {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  WeatherModelMain({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });
  WeatherModelMain.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure']?.toInt();
    humidity = json['humidity']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}

class WeatherModelWeather {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModelWeather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  WeatherModelWeather.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    main = json['main']?.toString();
    description = json['description']?.toString();
    icon = json['icon']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class WeatherModelCoord {
  double? lon;
  double? lat;

  WeatherModelCoord({
    this.lon,
    this.lat,
  });
  WeatherModelCoord.fromJson(Map<String, dynamic> json) {
    lon = json['lon']?.toDouble();
    lat = json['lat']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class WeatherModel {
  WeatherModelCoord? coord;
  List<WeatherModelWeather?>? weather;
  String? base;
  WeatherModelMain? main;
  int? visibility;
  WeatherModelWind? wind;
  WeatherModelClouds? clouds;
  int? dt;
  WeatherModelSys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = (json['coord'] != null)
        ? WeatherModelCoord.fromJson(json['coord'])
        : null;
    if (json['weather'] != null) {
      final v = json['weather'];
      final arr0 = <WeatherModelWeather>[];
      v.forEach((v) {
        arr0.add(WeatherModelWeather.fromJson(v));
      });
      weather = arr0;
    }
    base = json['base']?.toString();
    main =
        (json['main'] != null) ? WeatherModelMain.fromJson(json['main']) : null;
    visibility = json['visibility']?.toInt();
    wind =
        (json['wind'] != null) ? WeatherModelWind.fromJson(json['wind']) : null;
    clouds = (json['clouds'] != null)
        ? WeatherModelClouds.fromJson(json['clouds'])
        : null;
    dt = json['dt']?.toInt();
    sys = (json['sys'] != null) ? WeatherModelSys.fromJson(json['sys']) : null;
    timezone = json['timezone']?.toInt();
    id = json['id']?.toInt();
    name = json['name']?.toString();
    cod = json['cod']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (weather != null) {
      final v = weather;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['weather'] = arr0;
    }
    data['base'] = base;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}
