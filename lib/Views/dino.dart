import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

int gravity = 2500;
const int worlToPixelRatio = 10;
double initialVelocity = 30;
double acceleration = 1;
int dayNightOffest = 1000;
double jumpVelocity = 850;

abstract class GameObject {
  Widget render();
  Rect getRect(Size screenSize, double runDistance);
  void update(Duration lastUpdate, Duration elapsedTime) {}
}

class Sprite {
  late String imagePath;
  late int imageWidth;
  late int imageHeight;
}


List<Sprite> cacti = [
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_group.png"
    ..imageWidth = 104
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_large_1.png"
    ..imageWidth = 50
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_large_2.png"
    ..imageWidth = 98
    ..imageHeight = 100,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_1.png"
    ..imageWidth = 34
    ..imageHeight = 70,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_2.png"
    ..imageWidth = 68
    ..imageHeight = 70,
  Sprite()
    ..imagePath = "assets/images/cacti/cacti_small_3.png"
    ..imageWidth = 107
    ..imageHeight = 70,
];

class Cactus extends GameObject {
  final Sprite sprite;
  final Offset worldLocation;

  Cactus({required this.worldLocation}) : sprite = cacti[Random().nextInt(cacti.length)];

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio,
      screenSize.height / 1.75 - sprite.imageHeight,
      sprite.imageWidth.toDouble(),
      sprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(sprite.imagePath);
  }
}

Sprite cloudSprite = Sprite()
  ..imagePath = "assets/images/cloud.png"
  ..imageWidth = 92
  ..imageHeight = 27;

class Cloud extends GameObject {
  final Offset worldLocation;

  Cloud({required this.worldLocation});

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio / 5,
      screenSize.height / 3 - cloudSprite.imageHeight - worldLocation.dy,
      cloudSprite.imageWidth.toDouble(),
      cloudSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(cloudSprite.imagePath);
  }
}

List<Sprite> dino = [
  Sprite()
    ..imagePath = "assets/images/dino/dino_1.png"
    ..imageWidth = 88
    ..imageHeight = 94,
  Sprite()
    ..imagePath = "assets/images/dino/dino_2.png"
    ..imageWidth = 88
    ..imageHeight = 94,
  Sprite()
    ..imagePath = "assets/images/dino/dino_3.png"
    ..imageWidth = 88
    ..imageHeight = 94,
  Sprite()
    ..imagePath = "assets/images/dino/dino_4.png"
    ..imageWidth = 88
    ..imageHeight = 94,
  Sprite()
    ..imagePath = "assets/images/dino/dino_5.png"
    ..imageWidth = 88
    ..imageHeight = 94,
  Sprite()
    ..imagePath = "assets/images/dino/dino_6.png"
    ..imageWidth = 88
    ..imageHeight = 94,
];

enum DinoState {
  jumping,
  running,
  dead,
}

class Dino extends GameObject {
  Sprite currentSprite = dino[0];
  double dispY = 0;
  double velY = 0;
  DinoState state = DinoState.running;

  @override
  Widget render() {
    return Image.asset(currentSprite.imagePath);
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      screenSize.width / 10,
      screenSize.height / 1.75 - currentSprite.imageHeight - dispY,
      currentSprite.imageWidth.toDouble(),
      currentSprite.imageHeight.toDouble(),
    );
  }

  @override
  void update(Duration lastUpdate, Duration? elapsedTime) {
    double elapsedTimeSeconds;
    try {
      currentSprite = dino[(elapsedTime!.inMilliseconds / 100).floor() % 2 + 2];
    } catch (_) {
      currentSprite = dino[0];
    }
    try{
      elapsedTimeSeconds = (elapsedTime! - lastUpdate).inMilliseconds / 1000;
    }
    catch(_){
      elapsedTimeSeconds = 0;
    }


    dispY += velY * elapsedTimeSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      state = DinoState.running;
    } else {
      velY -= gravity * elapsedTimeSeconds;
    }
  }

  void jump() {
    if (state != DinoState.jumping) {
      state = DinoState.jumping;
      velY = jumpVelocity;
    }
  }

  void die() {
    currentSprite = dino[5];
    state = DinoState.dead;
  }
}

Sprite groundSprite = Sprite()
  ..imagePath = "assets/images/ground.png"
  ..imageWidth = 2399
  ..imageHeight = 24;

class Ground extends GameObject {
  final Offset worldLocation;

  Ground({required this.worldLocation});

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worlToPixelRatio,
      screenSize.height / 1.75 - groundSprite.imageHeight,
      groundSprite.imageWidth.toDouble(),
      groundSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(groundSprite.imagePath);
  }
}

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      title: 'Flutter Dino',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Dino dino = Dino();
  double runVelocity = initialVelocity;
  double runDistance = 0;
  int highScore = 0;
  TextEditingController gravityController =
  TextEditingController(text: gravity.toString());
  TextEditingController accelerationController =
  TextEditingController(text: acceleration.toString());
  TextEditingController jumpVelocityController =
  TextEditingController(text: jumpVelocity.toString());
  TextEditingController runVelocityController =
  TextEditingController(text: initialVelocity.toString());
  TextEditingController dayNightOffestController =
  TextEditingController(text: dayNightOffest.toString());

  late AnimationController worldController;
  Duration lastUpdateCall = const Duration();

  List<Cactus> cacti = [Cactus(worldLocation: const Offset(200, 0))];

  List<Ground> ground = [
    Ground(worldLocation: const Offset(0, 0)),
    Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
  ];

  List<Cloud> clouds = [
    Cloud(worldLocation: const Offset(100, 20)),
    Cloud(worldLocation: const Offset(200, 10)),
    Cloud(worldLocation: const Offset(350, -10)),
  ];

  @override
  void initState() {
    super.initState();
    worldController =
        AnimationController(vsync: this, duration: const Duration(days: 99));
    worldController.addListener(_update);
    // worldController.forward();
    _die();
  }

  void _die() {
    setState(() {
      worldController.stop();
      dino.die();
    });
  }

  void _newGame() {
    setState(() {
      highScore = max(highScore, runDistance.toInt());
      runDistance = 0;
      runVelocity = initialVelocity;
      dino.state = DinoState.running;
      dino.dispY = 0;
      worldController.reset();
      cacti = [
        Cactus(worldLocation: const Offset(200, 0)),
        Cactus(worldLocation: const Offset(300, 0)),
        Cactus(worldLocation: const Offset(450, 0)),
      ];

      ground = [
        Ground(worldLocation: const Offset(0, 0)),
        Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
      ];

      clouds = [
        Cloud(worldLocation: const Offset(100, 20)),
        Cloud(worldLocation: const Offset(200, 10)),
        Cloud(worldLocation: const Offset(350, -15)),
        Cloud(worldLocation: const Offset(500, 10)),
        Cloud(worldLocation: const Offset(550, -10)),
      ];

      worldController.forward();
    });
  }

  _update() {
    try {
      double elapsedTimeSeconds;
      dino.update(lastUpdateCall, worldController.lastElapsedDuration);
      try {
        elapsedTimeSeconds =
            (worldController.lastElapsedDuration! - lastUpdateCall)
                .inMilliseconds /
                1000;
      } catch (_) {
        elapsedTimeSeconds = 0;
      }

      runDistance += runVelocity * elapsedTimeSeconds;
      if (runDistance < 0) runDistance = 0;
      runVelocity += acceleration * elapsedTimeSeconds;

      Size screenSize = MediaQuery.of(context).size;

      Rect dinoRect = dino.getRect(screenSize, runDistance);
      for (Cactus cactus in cacti) {
        Rect obstacleRect = cactus.getRect(screenSize, runDistance);
        if (dinoRect.overlaps(obstacleRect.deflate(20))) {
          _die();
        }

        if (obstacleRect.right < 0) {
          setState(() {
            cacti.remove(cactus);
            cacti.add(Cactus(
                worldLocation: Offset(
                    runDistance +
                        Random().nextInt(100) +
                        MediaQuery.of(context).size.width / worlToPixelRatio,
                    0)));
          });
        }
      }

      for (Ground groundlet in ground) {
        if (groundlet.getRect(screenSize, runDistance).right < 0) {
          setState(() {
            ground.remove(groundlet);
            ground.add(
              Ground(
                worldLocation: Offset(
                  ground.last.worldLocation.dx + groundSprite.imageWidth / 10,
                  0,
                ),
              ),
            );
          });
        }
      }

      for (Cloud cloud in clouds) {
        if (cloud.getRect(screenSize, runDistance).right < 0) {
          setState(() {
            clouds.remove(cloud);
            clouds.add(
              Cloud(
                worldLocation: Offset(
                  clouds.last.worldLocation.dx +
                      Random().nextInt(200) +
                      MediaQuery.of(context).size.width / worlToPixelRatio,
                  Random().nextInt(50) - 25.0,
                ),
              ),
            );
          });
        }
      }

      lastUpdateCall = worldController.lastElapsedDuration!;
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    gravityController.dispose();
    accelerationController.dispose();
    jumpVelocityController.dispose();
    runVelocityController.dispose();
    dayNightOffestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];

    for (GameObject object in [...clouds, ...ground, ...cacti, dino]) {
      children.add(
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            Rect objectRect = object.getRect(screenSize, runDistance);
            return Positioned(
              left: objectRect.left,
              top: objectRect.top,
              width: objectRect.width,
              height: objectRect.height,
              child: object.render(),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 5000),
        color: (runDistance ~/ dayNightOffest) % 2 == 0
            ? Colors.white
            : Colors.black,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (dino.state != DinoState.dead) {
              dino.jump();
            }
            if (dino.state == DinoState.dead) {
              _newGame();
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...children,
              AnimatedBuilder(
                animation: worldController,
                builder: (context, _) {
                  return Positioned(
                    left: screenSize.width / 2 - 30,
                    top: 100,
                    child: Text(
                      'Score: ' + runDistance.toInt().toString(),
                      style: TextStyle(
                        color: (runDistance ~/ dayNightOffest) % 2 == 0
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: worldController,
                builder: (context, _) {
                  return Positioned(
                    left: screenSize.width / 2 - 50,
                    top: 120,
                    child: Text(
                      'High Score: ' + highScore.toString(),
                      style: TextStyle(
                        color: (runDistance ~/ dayNightOffest) % 2 == 0
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 20,
                top: 20,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    _die();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Change Physics"),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 25,
                                width: 280,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Gravity:"),
                                    SizedBox(
                                      child: TextField(
                                        controller: gravityController,
                                        key: UniqueKey(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      height: 25,
                                      width: 75,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 25,
                                width: 280,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Acceleration:"),
                                    SizedBox(
                                      child: TextField(
                                        controller: accelerationController,
                                        key: UniqueKey(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      height: 25,
                                      width: 75,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 25,
                                width: 280,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Initial Velocity:"),
                                    SizedBox(
                                      child: TextField(
                                        controller: runVelocityController,
                                        key: UniqueKey(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      height: 25,
                                      width: 75,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 25,
                                width: 280,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Jump Velocity:"),
                                    SizedBox(
                                      child: TextField(
                                        controller: jumpVelocityController,
                                        key: UniqueKey(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      height: 25,
                                      width: 75,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 25,
                                width: 280,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Day-Night Offset:"),
                                    SizedBox(
                                      child: TextField(
                                        controller: dayNightOffestController,
                                        key: UniqueKey(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      height: 25,
                                      width: 75,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                gravity = int.parse(gravityController.text);
                                acceleration =
                                    double.parse(accelerationController.text);
                                initialVelocity =
                                    double.parse(runVelocityController.text);
                                jumpVelocity =
                                    double.parse(jumpVelocityController.text);
                                dayNightOffest =
                                    int.parse(dayNightOffestController.text);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Done",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                child: TextButton(
                  onPressed: () {
                    _die();
                  },
                  child: const Text(
                    "Force Kill Dino",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
