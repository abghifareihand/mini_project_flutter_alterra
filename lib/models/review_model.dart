class ReviewModel {
  late int? id;
  late String nameResto;
  late String descResto;

  ReviewModel({
    this.id,
    required this.nameResto,
    required this.descResto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameResto': nameResto,
      'descResto': descResto,
    };
  }

  ReviewModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameResto = map['nameResto'];
    descResto = map['descResto'];
  }
}
