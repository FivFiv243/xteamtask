import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:xteamtask/fetures/map_logic/location_caller.dart';
import 'package:xteamtask/networking_api/open_weather_map_dio.dart';
import 'package:xteamtask/networking_api/weather_info_class.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

late LocationData _currentPosition;
WeatherInfoClass? weatherInfoClass;
Future _getLoc() async {
  _currentPosition = LocationData.fromMap(Map());
  _currentPosition = await fetchLocation();
}

Future _getInfo(LocationData location) async {
  weatherInfoClass = await OpenWeatherMapDio().GetWeatherData(location);
}

String LottieFileSrc(WeatherInfoClass? weatherInfoClass) {
  if (weatherInfoClass!.WeatherCode >= 801) {
    return "https://lottie.host/d6691922-e79f-454d-b12e-c85a72f499ab/7wlyrQOEl3.json";
  } else if (weatherInfoClass.WeatherCode == 800) {
    return "https://lottie.host/8338e4e0-60a3-419c-be29-763e59fa80c8/RZQSUwyb3o.json";
  } else if (weatherInfoClass.WeatherCode >= 701 && weatherInfoClass.WeatherCode <= 781) {
    return "https://lottie.host/62a871e6-dfad-46a9-9612-2e3ce3d09463/0bmWDSXkvZ.json";
  } else if (weatherInfoClass.WeatherCode >= 600 && weatherInfoClass.WeatherCode <= 622) {
    return "https://lottie.host/d7b7ea3d-145b-4e36-ab2b-0ebdcb780bb0/ZkbocdTd3c.json";
  } else if (weatherInfoClass.WeatherCode >= 500 && weatherInfoClass.WeatherCode <= 531 && weatherInfoClass.WeatherCode >= 300 && weatherInfoClass.WeatherCode <= 321) {
    return "https://lottie.host/1d01d2ad-b823-4db2-93df-c2cb150d3633/Uouc16xQMw.json";
  } else if (weatherInfoClass.WeatherCode >= 200 && weatherInfoClass.WeatherCode <= 232) {
    return "https://lottie.host/4a84e01d-239b-4144-8658-6f392560b8d0/4tZoL7J9b4.json";
  } else {
    return "";
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    _getLoc().whenComplete(() {
      _getInfo(_currentPosition).whenComplete(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Center(
            child: weatherInfoClass != null
                ? Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, QueryHight / 40, 0, 0)),
                      Text(weatherInfoClass!.Weather,
                          style: TextStyle(
                            fontSize: QueryHight / 20,
                          )),
                      Text(weatherInfoClass!.description,
                          style: TextStyle(
                            fontSize: QueryHight / 40,
                          )),
                      LottieBuilder.network(LottieFileSrc(weatherInfoClass)),
                      Padding(padding: EdgeInsets.fromLTRB(0, QueryHight / 25, 0, 0)),
                      Container(
                          width: QueryWidth / 1.5,
                          child: Row(children: [
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                                child: Column(children: [
                                  Text(
                                    "wind speed ",
                                    style: TextStyle(fontSize: QueryHight / 40),
                                  ),
                                  Text(
                                    weatherInfoClass!.WindSpeed.toString() + ' m/s',
                                    style: TextStyle(fontSize: QueryHight / 40),
                                  )
                                ])),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color: Colors.grey.withOpacity(0.25),
                              ),
                              child: Column(children: [
                                Text(
                                  "humidity ",
                                  style: TextStyle(fontSize: QueryHight / 40),
                                ),
                                Text(
                                  weatherInfoClass!.humidity.toString() + ' %',
                                  style: TextStyle(fontSize: QueryHight / 40),
                                )
                              ]),
                            )
                          ])),
                      Padding(padding: EdgeInsets.fromLTRB(0, QueryHight / 65, 0, 0)),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.5),
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        child: Text(
                          "You are now in " + weatherInfoClass!.timezone,
                          style: TextStyle(
                            fontSize: QueryHight / 45,
                          ),
                          maxLines: 5,
                        ),
                      )
                    ],
                  )
                : Center(child: CircularProgressIndicator())));
  }
}
