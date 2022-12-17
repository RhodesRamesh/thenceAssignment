class Data {
  Data(this.id, this.categoryId, this.imageUrl, this.name, this.rating, this.displaySize, this.availableSize, this.unit, this.price, this.priceUnit,
      this.description);

  int id;
  int categoryId;
  String imageUrl;
  String name;
  num rating;
  int displaySize;
  List availableSize;
  String unit;
  String price;
  String priceUnit;
  String description;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'name': name,
      'rating': rating,
      'displaySize': displaySize,
      'availableSize': availableSize,
      'unit': unit,
      'price': price,
      'priceUnit': priceUnit,
      'description': description,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      map['id'] as int,
      map['category_id'] as int,
      map['image_url'] as String,
      map['name'] as String,
      map['rating'] as num,
      map['display_size'] as int,
      map['available_size'] as List,
      map['unit'] as String,
      map['price'] as String,
      map['price_unit'] as String,
      map['description'] as String,
    );
  }
}
