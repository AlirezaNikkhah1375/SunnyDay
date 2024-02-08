import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_more_waste/models/weather_data_daily.dart';
import 'package:no_more_waste/utilities/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyDataForecast({Key? key, required this.weatherDataDaily})
      : super(key: key);

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('E').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: CustomColors.dividerLine.withAlpha(100),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        dailyList(),
      ]),
    );
  }

  Widget dailyList() {
    final int itemsCount =
        weatherDataDaily.daily.length > 7 ? 7 : weatherDataDaily.daily.length;

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: itemsCount,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(getDay(weatherDataDaily.daily[index].dt),
                          style: const TextStyle(
                              color: CustomColors.textColorBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: Text(
                        "${weatherDataDaily.daily[index].temp!.min}℃ / ${weatherDataDaily.daily[index].temp!.max}℃",
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                      ),
                    )
                  ],
                ),
              ),
              if (index != itemsCount - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: CustomColors.dividerLine,
                ),
            ],
          );
        }));
  }
}
