import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_in.dart';
import 'package:food_app/screens/review_cart/review_cart.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/viewmodels/providers/user_provider.dart';
import 'package:food_app/screens/home/drawer_side.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyProfile extends StatefulWidget {
  UserProvider userProvider;

  MyProfile({super.key, required this.userProvider});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> _signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    } catch (e) {
      // ignore: avoid_print
      print("Error signing out: $e");
    }
  }

  Widget listTile({IconData? icon, String? title}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title!),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;

    return Scaffold(
      backgroundColor: lightGreyBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      drawer: DrawerSide(
        userProvider: widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: lightGreyBackground,
              ),
              Container(
                //height: 548,
                height: 658,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: lightGreyBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    //bottomLeft: Radius.circular(30),
                    //bottomRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.userName!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(userData.userEmail!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReviewCart(),
                          ),
                        );
                      },
                      child: const ListTile(
                        leading: Icon(Icons.shop_outlined),
                        title: Text("My Orders"),
                      ),
                    ),
                    listTile(
                        icon: Icons.location_on_outlined,
                        title: "My Delivery Address"),
                    listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Terms & Conditions"),
                    listTile(
                        icon: Icons.policy_outlined, title: "Privacy Policy"),
                    listTile(icon: Icons.add_chart, title: "About"),
                    GestureDetector(
                      onTap: () async {
                        await _signOut();
                      },
                      child: const ListTile(
                        leading: Icon(Icons.exit_to_app_outlined),
                        title: Text("Log Out"),
                      ),
                    ),
                    // listTile(
                    //   icon: Icons.exit_to_app_outlined,
                    //   title: "Log Out",
                    //   onTap: () async {
                    //     await _signOut();
                    //   },
                    // ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userData.userImage ??
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                  ),
                  radius: 45,
                  backgroundColor: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
