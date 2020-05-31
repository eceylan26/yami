import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

///
/// create some example data.
///
class MockData {
  ///return a example list, by default, we have 10 sections,
  ///each section has 5 items.
  static List<ExampleSection> getExampleSections(
      [sectionSize = 10, itemSize = 5  , ElementData elem ] ) {
    var sections = List<ExampleSection>();
    for (int i = 0; i < sectionSize; i++) {
      var section = ExampleSection()
        ..header = elem.data[i].catName.toString()
        ..items = List.generate(itemSize, (index) => "List tile #$index")
        ..expanded = false;
      sections.add(section);
    }
    return sections;
  }
}


///Section model example
///
///Section model must implements ExpandableListSection<T>, each section has
///expand state, sublist. "T" is the model of each item in the sublist.
class ExampleSection implements ExpandableListSection<String> {
  //store expand state.
  bool expanded;
  //return item model list.
  List<String> items;

  //example header, optional
  String header;

  @override
  List<String> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}

class ElementData {
  final List<Category> data;
  ElementData({this.data});

  factory ElementData.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['VatozAS'] as List;
    print(list.runtimeType);
    List<Category> providersList = list.map((i) => Category.fromJson(i)).toList();

    return ElementData(
        data: providersList
    );
  }
}

class Category {
  final int id;
  final String catName;
  final List<Element> element;
  Category({this.id, this.catName, this.element});

  factory Category.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['Element'] as List;

    List<Element> providersList = list.map((i) {
      final Map<String, dynamic> data  = Map.from(i);
      Element.fromJson(data);
    }).toList();

    print("ttttttttttttt");
    print(providersList);
    print("ttttttttttttt");

    return Category(
        id: parsedJson['id'],
        catName: parsedJson['name'],
        element: providersList
    );
  }
}

class Element {
  final String price;
  final String elementName;
  final String info;
  Element({this.price, this.elementName, this.info});

  factory Element.fromJson(Map<String, dynamic> parsedJson){
    return Element(
        elementName:parsedJson['name'],
        price:parsedJson['price'],
        info:parsedJson['info']
    );
  }
}
