import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/services/api_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _locationController = TextEditingController();
  String API_Key = "d197d7ab2ef4d909bc2f2405d029d61e";
  String temperature = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            searchBar(context),
            elevatedButtons(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            currentTime(),
            currentDate(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            placeName(),
            temperatureGet(temperature),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            minMax(context),
          ],
        ),
      ),
    );
  }

  void fetchWeather(BuildContext context) async {
    // String location = "Delhi";
    String location = _locationController.text;
    try {
      var data = await ApiService.fetchWeather(API_Key, location);
      print(data);
      double temperatureInKelvin = data['main']['temp'];
      double temperatureInCelsius = temperatureInKelvin - 273.15;
      setState(() {
        temperature = temperatureInCelsius.toStringAsFixed(2);
      });
    } catch (e) {
      print("Error fetching weather data");
    }
  }

  Widget searchBar(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.1,
      // color: Colors.amber,
      child: TextField(
        controller: _locationController,
        decoration: InputDecoration(
          hintText: "enter location",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget elevatedButtons() {
    return ElevatedButton(
      onPressed: () {
        fetchWeather(context);
      },
      child: Text("Search"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }

  Widget placeName() {
    return Text(
      _locationController.text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget currentTime() {
    String currentTime = DateFormat('h:mm a').format(DateTime.now());
    return Text(
      currentTime,
      style: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget currentDate() {
    String currentDate = DateFormat('MMM d, y').format(DateTime.now());
    return Text(
      currentDate,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget temperatureGet(String temperature) {
    return Text(
      '$temperature ℃',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget minMax(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.indigo.shade500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Min  17",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Max 20",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Wind 5 m/s",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity 70%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
