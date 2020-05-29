import 'package:flutter/material.dart';
import 'package:yami/qr.dart';

void main(){
  runApp( MaterialApp(
    home:MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }

}

class MyPageState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRDeneme(),
          ),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 150.0,
                height: 150.0,
                padding: const EdgeInsets.all(8),
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage(
                        "assets/icon.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),

              Container(
                alignment: Alignment.center,
                width: 250.0,
                height: 50.0,
                padding: const EdgeInsets.all(8),
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage(
                        "assets/icon.jpg"),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          )
      ),
    );
  }
}