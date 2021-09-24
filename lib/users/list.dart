
import 'package:flutter/material.dart';
import 'package:placeholder/users/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Listtile extends StatefulWidget {
  const Listtile({Key? key}) : super(key: key);


  @override
  _ListtileState createState() => _ListtileState();
}
class _ListtileState extends State<Listtile> {
  int currentPage = 1;
  List<Album> album = [];

  // Change bool to List<Album> for future builder
  // Return the result instead of true
  Future <bool> fetchData() async
  {

      if (currentPage >= 10) {
        refreshController.loadNoData();
        return false;
    }
    final response = await http
        .get(Uri.parse('https://api.github.com/users/JakeWharton/repos?page=$currentPage&per_page=15'));

    if (response.statusCode == 200) {
      currentPage++;
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final result = albumFromJson(response.body);
        album.addAll(result);
      setState(() {

      });
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
   fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: fetchData(),
          builder: (BuildContext context , AsyncSnapshot  snapshot)
          {
            return  SmartRefresher(
              enablePullUp: true,
             /* onRefresh: ()
                {
                  currentPage = 1;
                  fetchData();
                  refreshController.refreshCompleted();
                },*/
              onLoading: () async
              {
                fetchData();
                refreshController.refreshCompleted();
              },
              controller: refreshController,
              child: ListView.builder(
                itemCount: album.length,
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
                            album[index].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          trailing: Text(album[index].id.toString()),
                          subtitle: Text(
                            album[index].description,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700]
                            ),
                          ),
                          onTap: () async
                          {
                            await launch(album[index].htmlUrl);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
