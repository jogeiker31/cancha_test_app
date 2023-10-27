import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class WeatherData extends StatelessWidget {
  const WeatherData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SchedulingService schedulingService =
        Provider.of<SchedulingService>(context);

    final weatherData = schedulingService.weatherData!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Probabilidad de lluvia",
                  style: AppStyles.subtitleStyle),
              const SizedBox(
                height: 15,
              ),
              Text(
                schedulingService.dayweek,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(schedulingService.dateInText),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    weatherData.iconSky,
                    width: 80,
                  ),
                  Container(
                    width: 2,
                    height: 80,
                    color: Colors.black,
                  ),
                  Text(
                    "${weatherData.firstPeriod!.avgTempC} °C",
                    style: const TextStyle(fontSize: 30),
                  )
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: SvgPicture.asset(
                  "assets/vectors/icon_raindrops.svg",
                  width: 12,
                )),
            Text("${weatherData.firstPeriod!.pop}%"),
            const SizedBox(
              height: 15,
            ),
            CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: SvgPicture.asset(
                  "assets/vectors/icon_strong_wind.svg",
                  width: 12,
                )),
            Text("${weatherData.firstPeriod!.windSpeedKph} km/h"),
            const SizedBox(
              height: 15,
            ),
            CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: SvgPicture.asset(
                  "assets/vectors/icon_cloud.svg",
                  width: 12,
                )),
            Text("${weatherData.firstPeriod!.sky}%")
          ],
        )
      ],
    );
  }
}
