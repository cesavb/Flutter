import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(
      {super.key,
      required this.title,
      required this.id,
      required this.poster,
      required this.gen,
      required this.day,
      required this.hour,
      required this.summary});

  final String title;
  final int id;
  final String poster;
  final String gen;
  final String summary;
  final String day;
  final String hour;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final controller = Homecontroller();

  _success() {
    final Size size = MediaQuery.of(context).size;
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: sidePadding,
                child: Image.network(widget.poster.toString()),
              ),
            ),
            Container(
                child: Column(
              children: [
                Text(widget.title),
              ],
            )),
            Container(
                child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Text(widget.summary))),
          ]),
        );
      },
    );
  }

  _error() {
    return Center(
        child: ElevatedButton(
            onPressed: (() {
              controller.start(widget.id);
            }),
            child: Text('Tente Novamente')));
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagemente(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    var id = widget.id;
    controller.start(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagemente(controller.state.value);
          },
        ));
  }
}
