import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  late stt.SpeechToText _speech;
  bool isStarted = false;
  bool isListening = false;
  bool isComplete = false;
  String _text = "";
  List<String> messages = [
    "Today's a normal day",
    "Slight swelling on the forehead injury once again",
    "General First aid worked but may need doc's advice"
  ];

  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mic),
        onPressed: () {
          _listen();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, int idx) {
                    return GestureDetector(
                      child: Card(
                        elevation: 2.0,
                        child: ListTile(
                          leading: Text(messages[idx]),
                        ),
                      ),
                      onDoubleTap: () {
                        setState(() {
                          messages.removeAt(idx);
                        });
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "done") {
            setState(() {
              isComplete = true;
              isListening = false;
              messages.add(_text);
            });
          }
        },
        onError: (val) {},
      );
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
