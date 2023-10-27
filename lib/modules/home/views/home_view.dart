import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/modules/add_scheduling/view/add_scheduling_view.dart';
import 'package:canchas_test_app/modules/home/provider/service/home_service.dart';

import 'package:canchas_test_app/modules/home/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const route = "/home";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeService = Provider.of<HomeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendamientos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(AddSchedulingView.route)
                .then((value) {
              if (value == true) {
                homeService.getSchedulingData();
              }
            });
          }),
      body: SingleChildScrollView(
        child: Column(children: List.from(homeService.schedulingData.map((e) {
          return Scheduling(
            data: e,
            delete: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return const DeleteDialog();
                  }).then((value) {
                if (value == true) {
                  homeService.removeScheduling(e.id);
                }
              });
            },
          );
        }))),
      ),
    );
  }
}
