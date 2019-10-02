import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasUserVoted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Band Names"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        onPressed: () {
          Navigator.pushNamed(context, '/add-new');
        },
      ),
      body: loadStreamBuilder(),
    );
  }

  Widget loadStreamBuilder() {
      return StreamBuilder(
          stream: Firestore.instance.collection('/bandnames').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return SpinKitRing(
                color: Colors.blue,
                size: 80,
              );
            return ListView.builder(
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(snapshot.data.documents[index]['name']),
                      ),
                      Text(snapshot.data.documents[index]['votes'].toString()),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  onTap: () async {
                    String id = snapshot.data.documents[index].documentID;
                    await Firestore.instance
                        .collection('bandnames')
                        .document(id)
                        .updateData({
                      'votes': snapshot.data.documents[index]['votes'] + 1
                    });
                  },
                );
              },
            );
          });
  }
}
