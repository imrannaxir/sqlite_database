import 'package:flutter/material.dart';
import 'package:sqlite_database/db_handler.dart';
import 'package:sqlite_database/notes.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({required this.title, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  Future<List<NotesModel>>? notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: myHomeScreen(),
      floatingActionButton: myFloatingActionButton(),
    );
  }

  Widget myHomeScreen() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: notesList,
            builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  reverse: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        dbHelper!.update(
                          NotesModel(
                            id: snapshot.data![index].id!,
                            title: 'First Time Use Database',
                            age: 20,
                            description: 'Say Something about Database',
                            email: 'mani@gmail.com',
                          ),
                        );
                        setState(() {
                          notesList = dbHelper!.getNotesList();
                        });
                      },
                      child: Dismissible(
                        key: ValueKey<int>(snapshot.data![index].id!),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            dbHelper!.delete(
                              snapshot.data![index].id!,
                            );
                            notesList = dbHelper!.getNotesList();
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete_forever),
                        ),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              snapshot.data![index].title.toString(),
                            ),
                            subtitle: Text(
                              snapshot.data![index].description.toString(),
                            ),
                            trailing: Text(
                              snapshot.data![index].age.toString(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget myFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        await dbHelper!
            .insert(
          NotesModel(
            title: 'SQFLite Database',
            age: 22,
            description:
                'SQFlite is a plugin in flutter which is used to store the data. In SQFlite we perform many operations like insert , fetch, update, delete, etc. This operation is called CRUD Operations. Using this we can easily store the data in a local database.',
            email: 'imrannazeer2015804@gmail.com',
          ),
        )
            .then((value) {
          print('Data has been Added');

          setState(() {
            notesList = dbHelper!.getNotesList();
          });
        }).onError((error, stackTrace) {
          print(error.toString());
          print('Something went wrong');
        });
      },
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}



//import 'package:flutter/material.dart';
// import 'package:sqflite_database/db_helper.dart';
// import 'package:sqflite_database/dog.dart';


// class HomeScreen extends StatefulWidget {
//   final String title;
//   const HomeScreen({required this.title, super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   DBHelper? dbHelper;
//   List dog = [];

//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();
//     dbHelper = DBHelper();
//     dog = await dbHelper!.fetchDogs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: myHomeScreen(),
//       floatingActionButton: myFloatingActionButton(),
//     );
//   }

//   Widget myHomeScreen() {
//     return Column(
//       children: [
//         Expanded(
//           child: FutureBuilder(
//             future: dbHelper!.fetchDogs(),
//             builder: (context, AsyncSnapshot<List<Dog>> snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       elevation: 20,
//                       child: ListTile(
//                         title: CircleAvatar(
//                           child: Text(
//                             snapshot.data![index].id.toString(),
//                           ),
//                         ),
//                         subtitle: Text(
//                           snapshot.data![index].name,
//                         ),
//                         trailing: Text(
//                           snapshot.data![index].age.toString(),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(
//                   child: Text(
//                     "Null data",
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget myFloatingActionButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         FloatingActionButton(
//           onPressed: () async {
//             // await dbHelper!.insertDog();
//           },
//           child: const Icon(
//             Icons.add,
//             size: 32,
//           ),
//         ),
//         // FloatingActionButton(
//         //   onPressed: () {},
//         //   child: const Icon(
//         //     Icons.remove,
//         //     size: 32,
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
