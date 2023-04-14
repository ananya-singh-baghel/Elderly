import 'package:code_silver/Services/SendSMS.dart';
import 'package:code_silver/Views/Nearby.dart';
import 'package:code_silver/Views/Notes.dart';
import 'package:code_silver/Views/Track.dart';
import 'package:code_silver/Views/dino.dart';
import 'package:code_silver/Views/Widgets/MenuTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F6),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12),
                children: [

                  GestureDetector(
                    child: MenuTile().buildTile("SOS", Colors.redAccent),
                    onTap: () {
                      Get.snackbar("Code:Silver", "SMS Sent");
                      TwilioSMS().sendSMS(
                          "~~Code:Silver ALERT~~ A user that has listed you as an emergency contact has sent an SOS Alert.");
                    },
                  ),
                  GestureDetector(
                    child: MenuTile().buildTile("Notes", Colors.blue),
                    onTap: () {
                      Get.to(() => Journal());
                    },
                  ),
                  GestureDetector(
                    child: MenuTile().buildTile("Track", Colors.orangeAccent),
                    onTap: () {
                      Get.to(() => Track());
                    },
                  ),
                  GestureDetector(
                    child: MenuTile()
                        .buildTile("Nearby Hospitals", Colors.purple.shade300),
                    onTap: () {
                      Get.to(() => NearYou());
                    },
                  ),
                  MenuTile().buildTile("meditation", Colors.lightGreen),

                  GestureDetector(
                    child: MenuTile().buildTile("Dino game", Colors.greenAccent),
                    onTap: () {
                      Get.to(() => main());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
