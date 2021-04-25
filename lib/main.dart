import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void change(Widget b) {
    setState(() {
      bb = b;
    });
  }

  Widget management = (Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [Text("when harvest"), Text("May")],
        ),
        Row(
          children: [
            Text("water plants time"),
            Text("12 hour"),
            new CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              center: new Text("100%"),
              progressColor: Colors.green,
            )
          ],
        )
      ],
    ),
  ));

  Widget bb = (Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text("when harvest : May"),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text("water plants time : 12 hour"),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 7.0,
            percent: 0.7,
            center: new Text("left 3.6 hour"),
            progressColor: Colors.green,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: OutlineButton(
            onPressed: () {},
            child: Text("My Product"),
          ),
        )
      ],
    ),
  ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: bb,
        bottomNavigationBar: BottomAppBar(),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset("img/menubg.jpg"),
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              ),
              ListTile(
                title: Text('management'),
                onTap: () {
                  setState(() {
                    bb = management;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('purchase'),
                onTap: () {
                  setState(() {
                    bb = purchase();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }

  Widget sell() {
    final List<CropBean> sellData = [
      CropBean("daniel", "corn", "img/product/1.jpg", 5, "Nigeria"),
      CropBean("daniel", "cotton", "img/product/2.jpg", 25, "Ethiopia"),
      CropBean("daniel", "corn", "img/product/1.jpg", 5, "Nigeria")
    ];
    var rng = new Random();
    return (Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: null,
            )
          ],
        ),
        ListView(
          children: [
            for (var item in sellData) createSell(item, rng.nextInt(99))
          ],
        )
      ],
    ));
  }

  Widget createSell(CropBean info, int out) {
    return (Row(
      children: [
        Text(info.product),
        Text(info.origin),
        Text(info.quota.toString()),
        Text(out.toString())
      ],
    ));
  }

  Widget product(CropBean info) {
    List<Widget> content = [
      Padding(padding: EdgeInsets.all(5), child: Text(info.product)),
      Padding(
        padding: EdgeInsets.all(5),
        child: Text("Farmer : " + info.name),
      ),
      Padding(
        padding: EdgeInsets.all(5),
        child: Text("Quota Price : " + info.quota.toString()),
      ),
      Padding(
          padding: EdgeInsets.all(5), child: Text("Origin : " + info.origin)),
    ];
    return (Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(info.productImg),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: content,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: OutlineButton(
                  child: Text("Buy"),
                  onPressed: () {},
                )),
                Expanded(
                    child: OutlineButton(
                  child: Text("Talk with ..."),
                  onPressed: () {},
                )),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget createCorpItem(CropBean cropBean) {
    return (GestureDetector(
      onTap: () {
        setState(() {
          bb = product(cropBean);
        });
      },
      child: Row(
        children: [
          Image.asset(
            cropBean.productImg,
            height: 150,
            width: 150,
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "farmer : " + cropBean.name,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "corp : " + cropBean.product,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "quota price : " + cropBean.quota.toString(),
                    textAlign: TextAlign.left,
                  )
                ],
              ))
        ],
      ),
    ));
  }

  Widget purchase() {
    final List<CropBean> data = [
      CropBean("daniel", "corn", "img/product/1.jpg", 5, "Nigeria"),
      CropBean("Matthew Baxter", "cotton", "img/product/2.jpg", 25, "Ethiopia"),
      CropBean("Bernard Penar", "wheat", "img/product/3.jpg", 5, "Nigeria")
    ];
    return (Container(
      child: SafeArea(
        child: ListView(
          children: [for (var item in data) createCorpItem(item)],
        ),
      ),
    ));
  }
}

class CropBean {
  final String name;
  final String product;
  final String productImg;
  final int quota;
  final String origin;
  CropBean(this.name, this.product, this.productImg, this.quota, this.origin)
      : super();
}
