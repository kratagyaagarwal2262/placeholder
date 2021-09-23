import 'package:flutter/material.dart';
import 'package:placeholder/users/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'network.dart';

class Listtile extends StatefulWidget {
  const Listtile({Key? key}) : super(key: key);

  @override
  _ListtileState createState() => _ListtileState();
}
class _ListtileState extends State<Listtile> {
  late Future <List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder <List<Album>>(
          future: futureAlbum,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context , int index)
                {
                  return Container(
                    color: Colors.blue,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      elevation: 10.0,
                      shadowColor: Colors.blue,
                      child: ListTileTheme(
                        minLeadingWidth: 2.0,
                        minVerticalPadding: 10.0,
                        iconColor: Colors.lightBlueAccent,
                        child: ListTile(
                          focusColor: Colors.blue,
                          leading: Icon(Icons.book, size: 50.0,),
                          title: Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          trailing: Text(snapshot.data[index].id.toString()),
                          subtitle: Text(
                            snapshot.data[index].description,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700]
                            ),
                          ),
                          onTap: () async
                          {
                            await launch(snapshot.data[index].htmlUrl);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
