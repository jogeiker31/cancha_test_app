import 'package:canchas_test_app/core/models/api_response.dart';
import 'package:canchas_test_app/modules/home/home.dart';

import 'package:canchas_test_app/presentation/colors.dart';
import 'package:flutter/material.dart';

import "package:flutter_svg/flutter_svg.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({super.key, required this.data, required this.delete});
  final SchedulingDataModel data;

  final Function delete;

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  ApiResponse? weather;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<HomeService>(context, listen: false)
          .getWeatherByDate(widget.data.schedulingModel.date)
          .then((value) {
        setState(() {
          weather = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _Image(
                url: widget.data.image,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data.courtName,
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () => widget.delete.call(),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    _Date(
                      date: widget.data.date,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    _User(
                      name: widget.data.name,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      "Probabilidad de lluvia",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    if (weather?.firstPeriod != null)
                      _Weather(
                        weather: weather!,
                      ),
                    if (weather != null && weather!.firstPeriod == null)
                      const Text("No hay datos del clima")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Weather extends StatelessWidget {
  const _Weather({
    required this.weather,
  });
  final ApiResponse weather;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("${weather.firstPeriod!.pop}%"),
        const SizedBox(
          width: 60,
        ),
        SvgPicture.asset(
          weather.iconSky,
          width: 30,
        )
      ],
    );
  }
}

class _User extends StatelessWidget {
  const _User({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Agendada",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.25)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(name,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({
    required this.date,
  });
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Fecha",
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.25)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(DateFormat("dd/MM/yyyy").format(date),
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 3,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            width: 120,
            height: 110,
            fit: BoxFit.cover,
            image: AssetImage(url),
          ),
        ));
  }
}
