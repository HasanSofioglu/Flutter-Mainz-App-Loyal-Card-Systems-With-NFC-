class Restaurant {
  String imageUrl;
  String title;
  String description;
  int price;
  double rating;

  Restaurant(
      {this.description, this.imageUrl, this.price, this.rating, this.title});
}

final List<Restaurant> restaurants = [
  Restaurant(
    imageUrl: 'assets/restaurants/starbucks.jpg',
    title: 'Sturbucks',
    description: 'Mainz, Frankfurt',
    price: 180,
    rating: 4,
  ),
  Restaurant(
    imageUrl: 'assets/restaurants/r1.jpg',
    title: 'Coffe Shop',
    description: 'River, Frankfurt',
    price: 180,
    rating: 3,
  ),
  Restaurant(
    imageUrl: 'assets/restaurants/r2.jpg',
    title: 'Kahve Dünyası',
    description: 'Gallus, Frankfurt',
    price: 180,
    rating: 1,
  ),
  Restaurant(
    imageUrl: 'assets/restaurants/r3.jpg',
    title: 'IT Otomat',
    description: 'Mainz, Frankfurt',
    price: 180,
    rating: 5,
  )
];
