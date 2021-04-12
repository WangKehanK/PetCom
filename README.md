# PetCom

## Tech Stack

### Front end
Flutter

```
# flutter doctor
flutter run
```

Useful tools: 
- [Json_to_dart](https://javiercbk.github.io/json_to_dart/)
- [Docker with Spring](https://www.javainuse.com/devOps/docker/docker-mysql)
```
How to convert json to dart list?
  // http request
  late HttpService http;
  // json to dart
  BreederList? data;
  List<Breeder> _breeder = <Breeder>[];
  // helper
  bool _isLoading = false;
  bool _hasMore = true;
  int currentPage = 1;

  //fetch a list of breeder from page i
  Future getBreeder(_currentPage) async {
    Response response;
    try {
      _isLoading = true;
      response = await http
          .getRequest("/api/breeder?current=" + _currentPage.toString());
      // if (response.data['code'] == '200') {}
      setState(() {
        data = BreederList.fromJson(jsonDecode(response.data));
        _breeder = data!.breeder!;
      });
      _isLoading = false;
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }
```

### Server
Spring, MyBatis, Maven...

Under /community folder
```
docker-compose up
```

### Database

Mysql 8.0


## Team Member

- Kehan Wang - Software Engineer
- Xiaoxin Gan - Software Engineer
- Duo Xu - UI/UX Designer
- Minna Fang - Designer / Content Producer
- Zhaoyi Lin - Data Sceintist
- Luyi Lu - Content Producer
