class HomeModel {
  List<MostSalesBooks> mostSalesBooks;
  List<FreshBooks> freshsBooks;

  HomeModel({this.mostSalesBooks, this.freshsBooks});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['mostSalesBooks'] != null) {
      mostSalesBooks = new List<MostSalesBooks>();
      json['mostSalesBooks'].forEach((v) {
        mostSalesBooks.add(new MostSalesBooks.fromJson(v));
      });
    }
    if (json['freshsBooks'] != null) {
      freshsBooks = new List<FreshBooks>();
      json['freshsBooks'].forEach((v) {
        freshsBooks.add(new FreshBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostSalesBooks != null) {
      data['mostSalesBooks'] =
          this.mostSalesBooks.map((v) => v.toJson()).toList();
    }
    if (this.freshsBooks != null) {
      data['freshsBooks'] = this.freshsBooks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MostSalesBooks {
  String s0;
  String s1;
  String s2;
  String s3;
  String id;
  String pictureThumb;
  String name;
  String writer;

  MostSalesBooks(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.id,
      this.pictureThumb,
      this.name,
      this.writer});

  MostSalesBooks.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    id = json['id'];
    pictureThumb = json['picture_thumb'];
    name = json['name'];
    writer = json['writer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['id'] = this.id;
    data['picture_thumb'] = this.pictureThumb;
    data['name'] = this.name;
    data['writer'] = this.writer;
    return data;
  }
}

class FreshBooks {
  String id;
  String pictureThumb;
  String name;
  String writer;

  FreshBooks({this.id, this.pictureThumb, this.name, this.writer});

  FreshBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureThumb = json['picture_thumb'];
    name = json['name'];
    writer = json['writer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['picture_thumb'] = this.pictureThumb;
    data['name'] = this.name;
    data['writer'] = this.writer;
    return data;
  }
}