import 'package:api_call/data_modal.dart';
import 'package:api_call/list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ListViewModal(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ListViewModal _listViewModal = ListViewModal();

  showModalBotttomSheet(String method, BuildContext context, int index) {
    // String method;
    TextEditingController title = TextEditingController();
    TextEditingController body = TextEditingController();
    TextEditingController userId = TextEditingController();
    TextEditingController id = TextEditingController();
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Enter USER DATA"),
                ),
                if (method == 'create')
                  TextField(
                    controller: userId,
                    decoration: InputDecoration(
                      hintText: 'userId',
                    ),
                  ),
                if (method == 'create')
                  TextField(
                    controller: id,
                    decoration: InputDecoration(
                      hintText: 'id',
                    ),
                  ),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
                TextField(
                  controller: body,
                  decoration: InputDecoration(
                    hintText: 'body',
                  ),
                ),
                TextButton(
                    onPressed: () {
                      if (method == 'create') {
                        DataModal user = DataModal(
                          userId: int.parse(userId.text),
                          id: int.parse(id.text),
                          title: title.text,
                          body: body.text,
                        );

                        _listViewModal.create(user);
                      }
                      if (method == 'update') {
                        DataModal user = _listViewModal.data[index];
                        setState(() {
                          user.title = title.text;
                          user.body = body.text;
                        });
                        _listViewModal.update(_listViewModal.data[index], user);
                      }
                      Navigator.pop(context);
                    },
                    child: Text("SAVE"))
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    _listViewModal.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBotttomSheet("create", context, 1);
        },
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
                future: _listViewModal.checkForData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (_listViewModal.data.isNotEmpty)
                    return ListView.builder(
                        itemCount: _listViewModal.data.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("userId: " +
                                          _listViewModal.data[index].userId
                                              .toString()),
                                      Text("id: " +
                                          _listViewModal.data[index].id
                                              .toString()),
                                      Text(
                                          "title: ${_listViewModal.data[index].title}"),
                                      Text(
                                          "body: ${_listViewModal.data[index].body}"),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showModalBotttomSheet(
                                              "update", context, index);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          _listViewModal.delete(index);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  else {
                    return Text("NO DATA");
                  }
                })),
      ),
    );
  }
}
