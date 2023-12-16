class City{
  int id;
  String name;
  String country;

  City({required this.id,required this.name,required this.country});

  factory City.fromMap(Map<String, dynamic> record){
    return City(
        id: record['id'],
        name: record['name'],
        country: record['country']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'country': country,
    };
  }
}