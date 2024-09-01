import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Default to system theme
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController wtController = TextEditingController();
  TextEditingController cmController = TextEditingController();

  String result = '';
  Color bgColors = Colors.black;
  IconData iconData = Icons.question_mark;
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    // Determine the colors based on the theme mode

    final appBarColor = isToggled
        ? ColorConstants.appBarColorDark
        : ColorConstants.appBarColorLight;
    final backgroundColor = isToggled
        ? ColorConstants.backgroundColorDark
        : ColorConstants.backgroundColorLight;
    final textColor = isToggled
        ? ColorConstants.textColorDark
        : ColorConstants.textColorLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Your BMI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Switch(
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.grey[500],
            value: isToggled,
            onChanged: (value) {
              setState(() {
                isToggled = value;
              });
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'BMI',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              SizedBox(height: 40),
              TextField(
                controller: wtController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Weight (in KGs)',
                  prefixIcon: Icon(Icons.line_weight, color: textColor),
                  labelStyle: TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 40),
              TextField(
                controller: cmController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Height (in Cm)',
                  prefixIcon: Icon(Icons.height, color: textColor),
                  labelStyle: TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shadowColor: Color.fromARGB(54, 63, 81, 181),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  String wt = wtController.text;
                  String cm = cmController.text;

                  if (wt.isNotEmpty && cm.isNotEmpty) {
                    double weightOfPerson = double.parse(wt);
                    double heightOfPerson = double.parse(cm);

                    double bmi = (weightOfPerson * 10000) /
                        (heightOfPerson * heightOfPerson);

                    String displayBMI = bmi.toStringAsFixed(4);
                    String msg = '';

                    if (bmi > 25) {
                      msg = 'You are Overweight';
                      bgColors = Colors.red;
                      iconData = Icons.arrow_upward;
                    } else if (bmi < 18) {
                      msg = 'You are Underweight';
                      bgColors = Colors.orange;
                      iconData = Icons.arrow_downward;
                    } else {
                      msg = 'You are Healthy';
                      bgColors = Colors.green;
                      iconData = Icons.check;
                    }

                    setState(() {
                      result = '$msg\nYour BMI: $displayBMI';
                    });
                  } else {
                    setState(() {
                      result = 'Please fill all the required fields';
                    });
                  }
                },
                child: Text('Calculate'),
              ),
              SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      result,
                      style: TextStyle(fontSize: 15, color: textColor),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: bgColors,
                      child: Icon(iconData, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorConstants {
  static const Color appBarColorLight = Color(0xff3f51b5);
  static const Color appBarColorDark = Color(0xff2f2e3d);

  static const Color backgroundColorLight = Color(0xfff5f5f5);
  static const Color backgroundColorDark = Color(0xff2f2e3d);

  static const Color textColorLight = Color(0xff212121);
  static const Color textColorDark = Color(0xffffffff);
}
