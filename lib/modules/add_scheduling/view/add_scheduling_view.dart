import 'package:canchas_test_app/core/repository/api_repository.dart';
import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/modules/add_scheduling/widgets/widgets.dart';
import 'package:canchas_test_app/presentation/presentation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddSchedulingView extends StatelessWidget {
  static const route = "/addScheduling";
  const AddSchedulingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchedulingService(SchedulingRepository(), ApiRepository()),
      child: const AddSchedulingContent(),
    );
  }
}

class AddSchedulingContent extends StatelessWidget {
  const AddSchedulingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final schedulingService = Provider.of<SchedulingService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar cancha"),
      ),
      floatingActionButton: FloatingActionButton(
        disabledElevation: 0,
        onPressed: schedulingService.canCreate
            ? () {
                schedulingService.createScheduling().then((res) {
                  Navigator.pop(context, true);
                });
              }
            : null,
        child: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Canchas",
                style: AppStyles.subtitleStyle,
              ),
              const CourtsRow(),
              Row(
                children: [
                  Text(
                   schedulingService.available ?  "Disponible":"No disponible",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.25)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    schedulingService.available
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    color: schedulingService.available
                        ? AppColors.primaryColor
                        : Colors.red,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Datos",
                style: AppStyles.subtitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  schedulingService.name = value;
                },
                decoration: InputDecoration(
                    label: const Text("Nombre"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                controller: schedulingService.textController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 30 * 3)));

                  if (pickedDate != null) {
                    schedulingService.dateSelected = pickedDate;
                  }
                },
                decoration: AppStyles.datetimeInputDecoration,
              ),
              const SizedBox(
                height: 15,
              ),
              if (schedulingService.weatherData?.firstPeriod != null)
                const WeatherData(),
              if (schedulingService.weatherData != null &&
                  schedulingService.weatherData?.firstPeriod == null)
                const Text("No hay datos del clima")
            ],
          ),
        ),
      ),
    );
  }
}
