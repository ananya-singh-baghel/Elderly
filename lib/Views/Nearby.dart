import 'package:code_silver/Models/searchResult.dart';
import 'package:code_silver/Services/placesAPI.dart';
import 'package:code_silver/Views/Widgets/TherapyTile.dart';
import 'package:flutter/material.dart';

class NearYou extends StatefulWidget {
  const NearYou({Key? key}) : super(key: key);

  @override
  State<NearYou> createState() => _NearYouState();
}

class _NearYouState extends State<NearYou> {
  Color clr1 = Colors.green;
  late SearchResult? result;
  bool haveResult = false;

  Future getResults() async {
    result = await NearYouAPI().getResult();
    if (result != null) {
      setState(() {
        haveResult = true;
      });
    }
  }

  @override
  void initState() {
    getResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: haveResult
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return TherapyTile().buildTile(result!, index);
                },
                itemCount: result!.results!.length,
                shrinkWrap: true,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(color: clr1),
                ),
                SizedBox(height: 32),
                Text("Fetching Mental Health Experts near you!",
                    style: TextStyle(color: Colors.grey))
              ],
            ),
    );
  }
}
