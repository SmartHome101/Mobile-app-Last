import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class ApplicationWidget extends StatefulWidget {
  final item;
  final update;
  const ApplicationWidget(this.item, this.update);

  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  late bool isActive;
  late String key;

  @override
  Widget build(BuildContext context) {

    var entryList = widget.item.entries.toList();
    key = entryList[0].key;
    isActive = entryList[0].value;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: cardColor,
        border: Border.all(
          color: isActive ? (Colors.deepPurple[200])! : Colors.black,
          width: 3,
        ),
      ),
      height: 150,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('icons/' + key + '.png'),
                  height: 60,
                  color: isActive ? Colors.deepPurple[200] : Colors.white,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0)
                .copyWith(left: 15, bottom: 0, top: 5, right: 15),

            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: GoogleFonts.yantramanav(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: isActive ? Colors.deepPurple[200] : Colors.white,
                    ),
                  ),
                ),
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  isActive ? "On" : "Off",
                  style: GoogleFonts.yantramanav(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: isActive ? Colors.deepPurple[200] : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      widget.update(key, value);
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.deepPurple[200],
                  value: isActive,
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}