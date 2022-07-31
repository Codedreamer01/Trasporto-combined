import 'package:flutter/material.dart';
import 'package:sign_in/logged_in.dart';
import 'package:provider/provider.dart';
import '../google_sign_in.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      UserAccountsDrawerHeader(
        accountName: Text(user.displayName!),
        accountEmail: Text(user.email!),
        currentAccountPicture: CircleAvatar(
            child: ClipOval(
                child: Image.network(
          user.photoURL!,
          width: 90,
          height: 90,
        ))),
        decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'))),
      ),
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text('Favorites'),
        onTap: () => null,
      ),
      const Divider(),
      ListTile(
        title: const Text('Logout'),
        leading: const Icon(Icons.logout),
        onTap: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
      )
    ]));
  }
}
