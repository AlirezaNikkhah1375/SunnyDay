import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:no_more_waste/controllers/global_controller.dart';
import 'package:no_more_waste/widgets/current_weather_widget.dart';
import 'package:no_more_waste/widgets/daily_data_widget.dart';
import 'package:no_more_waste/widgets/header_widget.dart';
import 'package:no_more_waste/widgets/hourly_data_widget.dart';

import 'login.dart';

class Home extends StatelessWidget {
  Home({super.key});

//call location
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          elevation: 0.8,
        ),
        drawer: drawer(context),
        body: SafeArea(
          child: globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      const HeaderWidget(),
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                      Center(
                          heightFactor: 2,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      HourlyDataWidget(
                          weatherDataHourly: globalController
                              .getWeatherData()
                              .getHourlyWeather()),
                      const Center(
                        heightFactor: 2,
                        child: Text(
                          'Next Days',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DailyDataForecast(
                          weatherDataDaily: globalController
                              .getWeatherData()
                              .getDailyWeather())
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            // <-- SEE HERE
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text(
              "Alireza NIKKHAH",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "alireza.nikkhah@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
            ),
            title: const Text('Log out'),
            onTap: () {
              _signOut(context);
            },
          ),
          const AboutListTile(
            // <-- SEE HERE
            icon: Icon(
              Icons.info,
            ),
            applicationIcon: Icon(
              Icons.heart_broken,
            ),
            applicationName: 'No More Waste',
            applicationVersion: '0.0.1',
            applicationLegalese: '© 2023 No More Waste',
            aboutBoxChildren: [
              ///Content goes here...
            ],
            child: Text('About app'),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
    _boxLogin.clear();
    _boxLogin.put("loginStatus", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Login();
        },
      ),
    );
  }
}
