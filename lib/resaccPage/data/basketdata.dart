class BasketData {
  String id;
  String name;
  int units;
  int price;
  String image;
  String desc;
  int priceTotal;
  BasketData(
      {this.id,
      this.name,
      this.price,
      this.units,
      this.image,
      this.desc,
      this.priceTotal});
}

class CatalogModel {
  static final BasketsData = [];

  static int ptotal = 0;
  static String idRest;
  static String selectType;
}

class PriceData {
  int price;
  PriceData({this.price});
}
