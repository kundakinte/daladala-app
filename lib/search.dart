import 'package:flutter/material.dart';
import 'package:daladala_application_1/location.dart';
import 'package:daladala_application_1/first_page.dart';
import 'package:daladala_application_1/change_notif.dart';
import 'package:provider/provider.dart';

//TextEditingController location = TextEditingController();
//TextEditingController destination = TextEditingController();

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

//var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

@override
class _SearchPage extends State<SearchPage> {
  @override
  void initState() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  void dispose() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Enter Route/Ingiza Njia',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          /* leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              x = 0;
              Navigator.pop(context);
            },
          ),*/
          /*actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                if (appBloc.location.text == 'Your Location')
                  appBloc.sendDirectionsApiRequest(
                      appBloc.location.text, appBloc.destination.text,
                      userloc: appBloc.currentLocation);
                else
                  appBloc.sendDirectionsApiRequest(
                      appBloc.location.text, appBloc.destination.text);
                ++x;
                ++y;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RouteMap()),
                );
              },
            ),
          ],*/
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.gps_fixed),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.4,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LocationSearchPage()));
                              },
                              //onChanged: (value) => appBloc.searchPlaces(value),
                              controller: appBloc.location,
                              decoration: InputDecoration.collapsed(
                                  hintText:
                                      'Starting Location/Mahali pa Kuanzia',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 9.0,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place_sharp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.4,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DestinationSearchPage()));
                              },
                              controller: appBloc.destination,
                              /*textInputAction: TextInputAction.go,
                              onChanged: (value1) =>
                                  appBloc.searchPlaces1(value1),*/
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Destination/ Mwisho wa Safari',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 9.0,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              /*if (appBloc.location.text == 'Your Location')
                                appBloc.sendDirectionsApiRequest(
                                    appBloc.location.text,
                                    appBloc.destination.text,
                                    userloc: appBloc.currentLocation);
                              else*/
                              appBloc.sendDirectionsApiRequest(
                                  appBloc.location.text,
                                  appBloc.destination.text);
                              ++x;
                              ++y;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RouteMap()),
                              );
                            },
                            child: Text("go"))
                      ],
                    )
                  ],
                ),
              )),
        ),
        body: Column(
          children: [
            if (appBloc.currentLocation != null)
              ElevatedButton.icon(
                  onPressed: () {
                    appBloc.location.text = appBloc.ylocs[0].formatted_address;
                  },
                  icon: Icon(Icons.my_location_sharp),
                  label: Text("My Location"))
          ],
          /*children: [
          //Stack(children: [
          /* if (appBloc.searchResults != null &&
              appBloc.searchResults.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.darken))*/
          if (appBloc.searchResults != null)
            Container(
              height: 350.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        appBloc.searchResults[index].description,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        //location.selection = true;
                        location.text =
                            appBloc.searchResults[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults[index].placeId);
                      },
                    );
                  }),
            ),
          if (appBloc.searchResults1 != null &&
              appBloc.searchResults1.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken)),
          if (appBloc.searchResults1 != null)
            Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(appBloc.searchResults1[index].description,
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        //location.selection = true;
                        destination.text =
                            appBloc.searchResults1[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults1[index].placeId);
                      },
                    );
                  }),
            )
        ]*/
        ));
    //]));
    /*FutureBuilder<List<(
            future: http.get(url),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if
              List data = json.decode(snapshot.data);
              List busstop = [];
              List id1 = [];
              List tit = [];
              data.forEach((element) {
                busstop.add(element["userId"]);
                id1.add(element["id"]);
                tit.add(element["title"]);
              });
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Text(busstop[index]),
                            Text(id1[index]),
                            Text(
                              tit[index],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            })*/
  }
}

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({Key? key}) : super(key: key);

  @override
  _LocationSearchPage createState() => _LocationSearchPage();
}

//var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

@override
class _LocationSearchPage extends State<LocationSearchPage> {
  @override
  void initState() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  void dispose() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Enter Location',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              x = 0;
              Navigator.pop(context);
            },
          ),
          /*actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                appBloc.sendDirectionsApiRequest(
                    appBloc.location.text, appBloc.destination.text);
                ++x;
                ++y;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RouteMap()),
                );
              },
            ),
          ],*/
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.gps_fixed),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.63,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              onSubmitted: (v) {
                                Navigator.pop(context);
                              },
                              autofocus: true,
                              onChanged: (value) => appBloc.searchPlaces(value),
                              controller: appBloc.location,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'My Location',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: appBloc.location.clear,
                            icon: Icon(Icons.clear))
                      ],
                    ),
                    const SizedBox(
                      height: 9.0,
                    ),
                    /*Row(
                      children: [
                        const Icon(Icons.place_sharp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.4,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              //controller: ,
                              //onTap:
                              controller: destination,
                              textInputAction: TextInputAction.go,
                              onChanged: (value1) =>
                                  appBloc.searchPlaces1(value1),
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Destination',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),*/
                    const SizedBox(
                      height: 9.0,
                    ),
                    /*Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ++x;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RouteMap()),
                              );
                            },
                            child: Text("go"))
                      ],
                    )*/
                  ],
                ),
              )),
        ),
        body: Column(children: [
          //Stack(children: [
          /* if (appBloc.searchResults != null &&
              appBloc.searchResults.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.darken))*/
          if (appBloc.searchResults != null)
            Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        appBloc.searchResults[index].description,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        //location.selection = true;
                        appBloc.location.text =
                            appBloc.searchResults[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults[index].placeId);
                      },
                    );
                  }),
            ),
          /*if (appBloc.searchResults1 != null &&
              appBloc.searchResults1.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken)),
          if (appBloc.searchResults1 != null)
            Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(appBloc.searchResults1[index].description,
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        //location.selection = true;
                        destination.text =
                            appBloc.searchResults1[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults1[index].placeId);
                      },
                    );
                  }),
            )*/
        ]));
    //]));
    /*FutureBuilder<List<(
            future: http.get(url),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if
              List data = json.decode(snapshot.data);
              List busstop = [];
              List id1 = [];
              List tit = [];
              data.forEach((element) {
                busstop.add(element["userId"]);
                id1.add(element["id"]);
                tit.add(element["title"]);
              });
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Text(busstop[index]),
                            Text(id1[index]),
                            Text(
                              tit[index],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            })*/
  }
}

class DestinationSearchPage extends StatefulWidget {
  const DestinationSearchPage({Key? key}) : super(key: key);

  @override
  _DestinationSearchPage createState() => _DestinationSearchPage();
}

//var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

@override
class _DestinationSearchPage extends State<DestinationSearchPage> {
  @override
  void initState() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  void dispose() {
    final appBloc = Provider.of<AppBloc>(context, listen: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Enter Destination',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              x = 0;
              Navigator.pop(context);
            },
          ),
          /*actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                appBloc.sendDirectionsApiRequest(
                    appBloc.location.text, appBloc.destination.text);
                ++x;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RouteMap()),
                );
              },
            ),
          ],*/
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.5),
                child: Column(
                  children: [
                    /*Row(
                      children: [
                        const Icon(Icons.gps_fixed),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.4,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              onChanged: (value) => appBloc.searchPlaces(value),
                              controller: location,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'My Location',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    const SizedBox(
                      height: 9.0,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place_sharp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.63,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              onSubmitted: (v1) {
                                Navigator.pop(context);
                              },
                              autofocus: true,
                              controller: appBloc.destination,
                              //textInputAction: TextInputAction.go,
                              onChanged: (value1) =>
                                  appBloc.searchPlaces1(value1),
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Destination',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            onPressed: appBloc.destination.clear,
                            icon: Icon(Icons.clear))
                      ],
                    ),
                    const SizedBox(
                      height: 9.0,
                    ),
                    /*Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ++x;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RouteMap()),
                              );
                            },
                            child: Text("go"))
                      ],
                    )*/
                  ],
                ),
              )),
        ),
        body: Column(children: [
          //Stack(children: [
          /* if (appBloc.searchResults != null &&
              appBloc.searchResults.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.darken))*/
          if (appBloc.searchResults1 != null)
            Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        appBloc.searchResults1[index].description,
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        //location.selection = true;
                        appBloc.destination.text =
                            appBloc.searchResults1[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults1[index].placeId);
                      },
                    );
                  }),
            ),
          /*if (appBloc.searchResults1 != null &&
              appBloc.searchResults1.length != 0)
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken)),
          if (appBloc.searchResults1 != null)
            Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: appBloc.searchResults1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(appBloc.searchResults1[index].description,
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        //location.selection = true;
                        destination.text =
                            appBloc.searchResults1[index].description;
                        appBloc.setSelectedLocation(
                            appBloc.searchResults1[index].placeId);
                      },
                    );
                  }),
            )*/
        ]));
    //]));
    /*FutureBuilder<List<(
            future: http.get(url),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if
              List data = json.decode(snapshot.data);
              List busstop = [];
              List id1 = [];
              List tit = [];
              data.forEach((element) {
                busstop.add(element["userId"]);
                id1.add(element["id"]);
                tit.add(element["title"]);
              });
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Text(busstop[index]),
                            Text(id1[index]),
                            Text(
                              tit[index],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            })*/
  }
}

/*
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Enter Route',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.5),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.gps_fixed),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.4,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey[200],
                          ),
                          child: const TextField(
                            controller:  ,
                            decoration: InputDecoration.collapsed(
                                hintText: 'My Location',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.place_sharp),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.4,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey[200],
                          ),
                          child: const TextField(
                            controller: ,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Destination',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9.0,
                  )
                ],
              ),
            )),
      ),
    );
  }
} */
