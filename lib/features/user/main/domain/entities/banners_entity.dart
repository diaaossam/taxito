class BannersEntity {
  final int id;
  final String url;

  BannersEntity({required this.id, required this.url});
}

List<BannersEntity> staticsBanner(){
  return [
    BannersEntity(id: 1,url: "https://picsum.photos/250?image=9"),
    BannersEntity(id: 2,url: "https://picsum.photos/250?image=9"),
    BannersEntity(id: 3,url: "https://picsum.photos/250?image=9"),
    BannersEntity(id: 4,url: "https://picsum.photos/250?image=9"),
    BannersEntity(id: 5,url: "https://picsum.photos/250?image=9"),
  ];
}