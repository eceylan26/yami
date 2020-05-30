import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:yami/src/qr_code_variables.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';
import 'mock_data.dart';

class InstitutionPage extends StatefulWidget {
  final qrCodeResult;

  const InstitutionPage({
    Key key,
    @required this.qrCodeResult,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      InstitutionPageState(this.qrCodeResult);
}

class InstitutionPageState extends State<InstitutionPage> {
  String qrCodeResult;
  List<String> items;
  ElementData menuData;
  var sectionList ;


  InstitutionPageState(this.qrCodeResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text("Welcome to , $restaurantName",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/resto1.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: ExpandableListView(
            builder: SliverExpandableChildDelegate<String, ExampleSection>(
              sectionList: sectionList,
              itemBuilder: (context, sectionIndex, itemIndex, index) {
                String myitem = menuData.data[sectionIndex].element[itemIndex].elementName;
                String price = menuData.data[sectionIndex].element[itemIndex].price;
                return GestureDetector(
                  onTap: () {
                    print(sectionIndex);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(22),
                          bottomLeft: Radius.circular(22),
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22)),
                    ),
                    margin: EdgeInsets.fromLTRB(25, 1, 25, 1),
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      height: 40.0,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 7, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(myitem,
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  price,
                                  style: TextStyle(
                                    fontFamily: 'Exo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
              sectionBuilder: (context, containerInfo) => _SectionWidget(
                section: sectionList[containerInfo.sectionIndex],
                containerInfo: containerInfo,
                onStateChanged: () {
                  //notify ExpandableListView that expand state has changed.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      parserQRCode(this.qrCodeResult);
    });

    items = new List<String>();
    items.add("Americano");
    items.add("Sıcak Çikolota");
    items.add("Filtre Kahve");
    items.add("Türk Kahvesi");
    items.add("Çay");
    items.add("Kış Çayı");

    
    //dummy json
    var myjson2 =
        '''{"Categories":[{"id":1,"name":"Drink","Element":[{"name":"Tea","price":"5 TL","info":"Early Gray"},{"name":"Coffee Americano","price":"10 TL","info":"Filtre Coffee"}]},{"id":2,"name":"Food","Element":[{"name":"Salata","price":"10 TL","info":"Domates,Biber,Sogan"},{"name":"Bonfile Et","price":"25 TL","info":"Patetes Kızartmasıyla"}]},{"id":3,"name":"Dessert","Element":[{"name":"Mozail Tatlı","price":"15 TL","info":"Çikolata kaplı"},{"name":"CheeseCake","price":"20 TL","info":"Cafemizin gözdesi"}]}]}''';
    jsonObj = jsonDecode(myjson2);


    final jsonResponse=json.decode(myjson2);

    menuData = new ElementData.fromJson(jsonResponse);
    List<String> categoriesList = new List<String>();
    categoriesList = getCategories(menuData);

    for(int i = 0; i<categoriesList.length ;i++){
      print(categoriesList[i]);
    }

    sectionList = MockData.getExampleSections(menuData.data.length, menuData.data[0].element.length,menuData);



  }

  List<String> getCategories(ElementData elem){

    List<String> categories = new List<String>();

    for(int i = 0 ; i < elem.data.length;i++){
      categories.add(elem.data[i].catName.toString());
    }

    return categories;
  }

  //////////////////////////////////////
  //////   Parser for result of QR Code
  /////////////////////////////////////
  void parserQRCode(var qrTest) {
    restaurantName = qrTest.split("/")[3];
    tableNumber = qrTest.split("/")[4];

    print(restaurantName);
    print(tableNumber);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SectionWidget extends StatefulWidget {
  final ExampleSection section;
  final ExpandableSectionContainerInfo containerInfo;
  final VoidCallback onStateChanged;

  _SectionWidget({this.section, this.containerInfo, this.onStateChanged});

  @override
  __SectionWidgetState createState() => __SectionWidgetState();
}

class __SectionWidgetState extends State<_SectionWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  AnimationController _controller;

  Animation _iconTurns;

  Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _iconTurns =
        _controller.drive(_halfTween.chain(CurveTween(curve: Curves.easeIn)));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));

    if (widget.section.isSectionExpanded()) {
      _controller.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.containerInfo
      ..header = _buildHeader()
      ..content = _buildContent();
    return ExpandableSectionContainer(
      info: widget.containerInfo,
    );
  }

  Widget _buildHeader() {
    return Container(
      child: new GestureDetector(
        onTap: _onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
          ),
          margin: EdgeInsets.fromLTRB(20, 7, 20, 3),
          color: Colors.white,
          elevation: 5,
          child: Container(
            height: 75.0,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  height: 75.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage("assets/hamburger.jpg"),
                      )),
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        widget.section.header,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Exo',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    widget.section.setSectionExpanded(!widget.section.isSectionExpanded());
    if (widget.section.isSectionExpanded()) {
      if (mounted && widget.onStateChanged != null) {
        widget.onStateChanged();
      }
      _controller.forward().then((_) {});
    } else {
      _controller.reverse().then<void>((void value) {
        if (mounted && widget.onStateChanged != null) {
          widget.onStateChanged();
        }
      });
    }

  }

  Widget _buildContent() {
    return SizeTransition(
      sizeFactor: _heightFactor,
      child: widget.containerInfo.content,
    );
  }
}

