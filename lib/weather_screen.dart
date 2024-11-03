import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather_forcast_item.dart';
import 'package:weather_app/addition_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherr;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Jabalpur';

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=b4428472fa288fbcf6f1fcfda7a7bd00',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected errorrrrr occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weatherr = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(149, 32, 226, 229),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(5, 32, 226, 229),
            title: const Text(
              'Weather App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    //is used to rebuilt the func manage set and is used to rebuilt only one particular screen
                    weatherr = getCurrentWeather();
                  });
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 28,
                ),
              )
            ]),
        body: FutureBuilder(
          future: weatherr,
          builder: (context, snapshot) {
            //snapshot helps to handle states
            // print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;
            final store = data['list'][0];

            final currentWeatherTemp = store['main']['temp'] - 273.15;
            final t = currentWeatherTemp.toStringAsFixed(2);
            final currentsky = store['weather'][0]['main'];
            final currentHumidity = store['main']['humidity'];
            final currentpressure = store['main']['pressure'];
            final currenWindspeed = store['wind']['speed'];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //search container
                    // Container(
                    //   padding: const EdgeInsets.all(6),
                    //   margin: const EdgeInsets.fromLTRB(5, 0, 5, 25),
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 49, 52, 66),
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       //icon
                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Container(
                    //           margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                    //           child: const Icon(Icons.search),
                    //         ),
                    //       ),
                    //       //text field
                    //       const Expanded(
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //               hintText: 'search city',
                    //               border: InputBorder.none),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        // color:const Color.fromARGB(82, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$t °C' ,
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                 
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Icon(
                                    currentsky == 'Clouds' ||
                                            currentsky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 100,
                                    // color: Color.fromARGB(255, 39, 156, 229),
                                  ),
                                  const SizedBox(
                                    height: 07,
                                  ),
                                  Text(
                                    '$currentsky',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Hourly Forecast',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       for (int i = 0; i < 30; i++)
                    //         HourlyForecastItem(
                    //           time: data['list'][i + 1]['dt_txt'].toString(),
                    // icon: data['list'][i + 1]['weather'][0]['main'] =='Clouds' ||
                    //         data['list'][i + 1]['weather'][0]['main'] ==
                    //             'Rain'
                    //     ? Icons.cloud
                    //     : Icons.sunny,
                    //           temperature: data['list'][i + 1]['main']['temp'].toString(),
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final tt = hourlyForecast['main']['temp'] - 273.15;
                          final iconn =
                              data['list'][index + 1]['weather'][0]['main'];

                          final timee =
                              DateTime.parse(hourlyForecast['dt_txt']);
                          return HourlyForecastItem(
                              time: DateFormat.jm().format(timee),
                              icon: iconn == 'Clouds' || iconn == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              temperature: tt.toStringAsFixed(2));
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Additional Information',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AditionInfoItem(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: currentHumidity.toString()),
                        AditionInfoItem(
                            icon: Icons.air,
                            label: 'WindSpeeed',
                            value: currenWindspeed.toString()),
                        AditionInfoItem(
                            icon: Icons.beach_access,
                            label: 'Pressure',
                            value: currentpressure.toString()),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

// Container(
//                     padding: const EdgeInsets.all(6),
//                     margin: const EdgeInsets.fromLTRB(5, 0, 5, 28),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 26, 28, 35),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         //icon
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               cityName = searchController.text;
//                               weather = getCurrentWeather(cityName);
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
//                             child: const Icon(Icons.search),
//                           ),
//                         ),

//                         //sarch textfiled
//                         Expanded(
//                           child: TextField(
//                             controller: searchController,
//                             decoration: InputDecoration(
//                               hintText: 'Search $city',
//                               hintStyle: const TextStyle(color: Colors.white30),
//                               border: InputBorder.none,
//                             ),

// // Added this onSubmitted property to trigger search on Enter key press
//                             onSubmitted: (value) {
//                               setState(() {
//                                 cityName = value;
//                                 weather = getCurrentWeather(cityName);
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
