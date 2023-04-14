import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum trackPage { INIT, TRACKING, NEW }

class Track extends StatefulWidget {
  const Track({Key? key}) : super(key: key);

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  trackPage page = trackPage.INIT;
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  Map<String, String> trackers = {
    "test2@gmail.com": "1234567",
    "test3@gmail.com": "12345678",
  };
  Map<String, List<double>> locations = {
    "1234567": [12.9692, 79.1559],
    "12345678": [12.9165, 79.1325]
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: page == trackPage.INIT
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            page = trackPage.NEW;
                          });
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text("Add/Update Tracking details",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text("Track Somebody",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        onTap: () {
                          setState(() {
                            page = trackPage.TRACKING;
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            : page == trackPage.NEW
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 80),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            hintText: 'ex: test@gmail.com',
                          ),
                        ),
                        TextFormField(
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'Enter your password',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 32),
                        GestureDetector(
                          child: Chip(
                            label: Text(
                              "Add/Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          onTap: () {
                            trackers.addAll({
                              "${emailController.text}":
                                  "${passController.text}"
                            });
                            locations.addAll({
                              "${passController.text}": [12.9692, 79.1559]
                            });
                            setState(() {
                              page = trackPage.INIT;
                            });
                          },
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 80),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            hintText: 'ex: test@gmail.com',
                          ),
                        ),
                        TextFormField(
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'Enter your password',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 32),
                        GestureDetector(
                          child: Chip(
                            label: Text(
                              "Track",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          onTap: () {
                            if (trackers[emailController.text] ==
                                passController.text) {
                              Get.snackbar("Code:Silver",
                                  "Last known coordinates: ${locations[passController.text]![0]},${locations[passController.text]![1]} ");
                            }
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
