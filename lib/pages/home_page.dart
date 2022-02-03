import 'package:flutter/material.dart';
import 'package:twitter_ui/models/messages_model.dart';
import 'package:twitter_ui/widgets/message_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> messageUsers = [...users];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          const Divider(height: 2),
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: messageUsers.length,
              itemBuilder: (context, index) {
                final messagedUser = messageUsers[index];
                return TweetMessage(messagedUser: messagedUser);
              },
            ),
          ),
          const Divider(height: 2),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {},
        child: Image.asset(
          "assets/icons/icon_pero.png",
          height: 22,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          for (int i = 0; i < bottomBarIcons.length; i++)
            BottomNavigationBarItem(
              icon: Image.asset(
                bottomBarIcons[i],
                height: 20,
                color: selectedIndex == i
                    ? const Color(0xff4C9EEB)
                    : const Color(0xffBDC5CD),
              ),
              label: "",
            ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: Image.asset("assets/icons/twitter_logo.png", height: 22),
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 80,
      leading: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onPressed: () {},
        child: SizedBox(
          height: 37,
          width: 37,
          child: Stack(
            children: const [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/im_user_1.png"),
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 4.5,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 3.6,
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/icons/icon_star.png",
            height: 22,
          ),
        ),
      ],
    );
  }
}
