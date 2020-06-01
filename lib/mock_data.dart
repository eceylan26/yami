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
        ..expanded = true;
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
  List<Category> data = new List<Category>();

  void setData(Category cat){
    data.add(cat);
  }

}

class Category {
  final String catName;
  final List<Element> element ;
  Category({ this.catName, this.element});

  factory Category.fromJson(Map<String, dynamic> parsedJson){

    List<dynamic>  list = parsedJson['Element'] as List;

    List<Element> providersList = new List<Element>();

    for(int i = 0 ;i<list.length;i++){
      Map<String, dynamic> data  = Map.from(list[i]);
      providersList.add(Element.fromJson(data));
    }

    return Category(
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
        price:parsedJson['price'],
        elementName:parsedJson['name'],
        info:parsedJson['info']
    );
  }
}
