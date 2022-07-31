import 'package:flutter/material.dart';
import 'package:sign_in/second_screen/navbar.dart';
import 'constants.dart';
import 'package:sign_in/map/addstopmapscreen.dart';

String name = '';

class MyHomePage extends StatefulWidget {
  final String place;
  MyHomePage({Key? key, required this.place}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(place);
  String getName() {
    return place;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late String placeName1;

  _MyHomePageState(String placeName) {
    placeName1 = placeName;
  }
  final CategoriesScroller categoriesScroller = const CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = busdata;
    List<Widget> listItems = [];
    for (var post in responseList) {
      listItems.add(InkWell(
        child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Colors.cyan,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            post["name"],
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            post["time"],
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            " ${post["price"]}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      // Image.asset(
                      //   "assests/images/${post["image"]}",
                      //   height: double.infinity,
                      // )
                    ]))),
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Card(
                  color: Colors.cyan,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 225),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('bus name',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'via' /*+ direction from database*/,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '@' /*+ time from database */,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'close',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      )
                    ],
                  ),
                );
              });
        },
      ));
    }
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        drawer: NavBar(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan,
          // leading: const Icon(
          //   Icons.menu,
          //   color: Colors.white,
          // ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            /*IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person, color: Colors.white),
            )*/
          ],
        ),
        body: SizedBox(
            height: size.height,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    placeName1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  /* Text(
                    's',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),*/
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                  opacity: closeTopContainer ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer ? 0 : categoryHeight,
                      child: categoriesScroller)),
              Expanded(
                  child: ListView.builder(
                controller: controller,
                itemCount: itemsData.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  double scale = 1.0;
                  if (topContainer > 0.5) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return Opacity(
                    opacity: scale,
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.bottomCenter,
                      child: Align(
                        heightFactor: 0.7,
                        alignment: Alignment.topCenter,
                        child: itemsData[index],
                      ),
                    ),
                  );
                },
              )),
            ])),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 20),
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "Add a bus",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "<placeholder>",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                InkWell(
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 20),
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Add a Stop",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "<placeholder>",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddStopPage()),
                    );
                  },
                ),
                Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 20),
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Report",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "<placeholder>",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )
                          ],
                        )))
              ],
            ),
          )),
    );
  }
}

// class NavigationDrawerWidget extends StatelessWidget {
//   final padding = EdgeInsets.symmetric(horizontal: 20);
//   @override
//   Widget build(BuildContext context) {
//     final name = user.displayName!;
//     final displaypic = NetworkImage(user.photoURL!);
//     return Drawer(
//       child: Container(
//         child: ListView(
//           children: [
//             buildHeader(name: name, context: context),
//             const SizedBox(
//               height: 48,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader({
//     required String name,
//     required context,
//   }) =>
//       InkWell(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 40),
//           child: Row(children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundImage: NetworkImage(user.photoURL!),
//             ),
//             SizedBox(width: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 //Text(
//                 //email,
//                 //style: TextStyle(fontSize: 20),
//                 //)
//                 ElevatedButton(
//                     onPressed: () {
//                       final provider = Provider.of<GoogleSignInProvider>(
//                           context,
//                           listen: false);
//                       provider.logout();
//                     },
//                     child: Text('Logout'))
//               ],
//             )
//           ]),
//         ),
//       );
// }
