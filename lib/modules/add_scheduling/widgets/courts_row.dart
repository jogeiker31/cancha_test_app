import 'package:canchas_test_app/core/core.dart';
import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/presentation/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourtsRow extends StatelessWidget {
  const CourtsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final schedulingService = Provider.of<SchedulingService>(context);

    return Row(
      children: List.generate(CourtsData.courts.length, (index) {
        final court = CourtsData.courts[index];
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                schedulingService.courtSelected = court;
              },
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: schedulingService.courtSelected == court
                                ? 6
                                : 0,
                            color: schedulingService.available
                                ? AppColors.primaryColor
                                : Colors.red)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                          height: 80,
                          fit: BoxFit.cover,
                          image: AssetImage(court.image)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(court.name)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
