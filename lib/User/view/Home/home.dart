import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/profile/newchefprofile.dart';
import 'package:flavour_fusion/User/view/Home/notifications.dart';
import 'package:flavour_fusion/User/view/Recipes/Recipedetailpageuser.dart';
import 'package:flavour_fusion/User/view/profile/userprofile.dart';
import 'package:flavour_fusion/common/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/Chef/model/view/Home/notifications.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('UserAuth')
          .doc(user.uid)
          .get();

      setState(() {
        _profileImageUrl = userData['profileImage'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(0, 80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Userprofile(),
                      ));
                },
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null ? Icon(Icons.person) : null,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationUser(),
                          ));
                    },
                    icon: Icon(
                      Icons.notifications,
                      size: 35.w,
                      color: Colors.amber[300],
                    )),
              )
            ],
            centerTitle: true,
            toolbarHeight: 80,
            title: Text(
              'Flavour Fusion',
              style: GoogleFonts.dancingScript(
                  fontSize: 35, color: Colors.teal, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle_user('Recommended Recipes'),
              RecipesShow_user(
                height: 250,
                width: 200,
              ),
              SectionTitle_user('Popular recipes'),
              PopularRecipesShow_user(height: 180, width: 150),
              SectionTitle_user('Chef Recipes'),
              RecipesShow_user()
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedRecipe_user extends StatelessWidget {
  final double? height;
  final double? width;
  RecommendedRecipe_user(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: height!.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: width!.w,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SectionTitle_user extends StatelessWidget {
  final String title;

  SectionTitle_user(this.title);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 19.spMin,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface),
      ),
    );
  }
}

class RecipesShow_user extends StatefulWidget {
  final double height;
  final double width;
  const RecipesShow_user({Key? key, this.height = 180, this.width = 150})
      : super(key: key);

  @override
  _RecipesShow_userState createState() => _RecipesShow_userState();
}

class _RecipesShow_userState extends State<RecipesShow_user> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> _recipesStream;
  late Stream<DocumentSnapshot> _favoritesStream;

  @override
  void initState() {
    super.initState();
    _recipesStream = _firestore.collection('recipes').snapshots();
    _favoritesStream =
        _firestore.collection('userFavorites').doc(_userId).snapshots();
  }

  Future<void> _toggleFavorite(String recipeId, bool currentStatus) async {
    if (_userId == null) return;
    await _firestore.collection('userFavorites').doc(_userId).set({
      recipeId: !currentStatus,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<QuerySnapshot>(
      stream: _recipesStream,
      builder: (context, recipeSnapshot) {
        if (!recipeSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<DocumentSnapshot>(
          stream: _favoritesStream,
          builder: (context, favoriteSnapshot) {
            Map<String, dynamic> favorites =
                favoriteSnapshot.data?.data() as Map<String, dynamic>? ?? {};

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: widget.height,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipeSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var recipeDoc = recipeSnapshot.data!.docs[index];
                    var recipe = Recipe.fromMap(
                        recipeDoc.data() as Map<String, dynamic>);
                    bool isFavorite = favorites[recipeDoc.id] == true;
                    String recipeId = recipeDoc.id;
                    return SizedBox(
                      width: widget.width,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage_user(
                                    recipe: recipe, recipeId: recipeId),
                              ));
                        },
                        child: Card(
                          color: Theme.of(context).cardColor,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (recipe.imageUrls.isNotEmpty)
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(
                                          recipe.imageUrls[0],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      recipe.title,
                                      style: TextStyle(
                                          color: colorScheme.onSurface,
                                          fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : colorScheme.onSurface,
                                  ),
                                  onPressed: () =>
                                      _toggleFavorite(recipeDoc.id, isFavorite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
class PopularRecipesShow_user extends StatefulWidget {
  final double height;
  final double width;

  const PopularRecipesShow_user({
    Key? key,
    this.height = 180.0,
    this.width = 150.0,
  }) : super(key: key);

  @override
  _PopularRecipesShow_userState createState() => _PopularRecipesShow_userState();
}

class _PopularRecipesShow_userState extends State<PopularRecipesShow_user> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> _recipesStream;
  late Stream<DocumentSnapshot> _favoritesStream;

  @override
  void initState() {
    super.initState();
    _recipesStream = _firestore
        .collection('recipes')
        .orderBy('timestamp', descending: true)
        .snapshots();
    _favoritesStream =
        _firestore.collection('userFavorites').doc(_userId).snapshots();
  }

  Future<void> _toggleFavorite(String recipeId, bool currentStatus) async {
    if (_userId == null) return;
    await _firestore.collection('userFavorites').doc(_userId).set({
      recipeId: !currentStatus,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<QuerySnapshot>(
        stream: _recipesStream,
        builder: (context, recipeSnapshot) {
          if (!recipeSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: _favoritesStream,
            builder: (context, favoriteSnapshot) {
              Map<String, dynamic> favorites =
                  favoriteSnapshot.data?.data() as Map<String, dynamic>? ?? {};

              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: widget.height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var recipeDoc = recipeSnapshot.data!.docs[index];
                      var recipe = Recipe.fromMap(
                          recipeDoc.data() as Map<String, dynamic>);
                      bool isFavorite = favorites[recipeDoc.id] == true;
                      String recipeId = recipeDoc.id;

                      return SizedBox(
                        width: widget.width,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage_user(
                                  recipe: recipe,
                                  recipeId: recipeId,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (recipe.imageUrls.isNotEmpty)
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Image.network(
                                            recipe.imageUrls[0],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe.title,
                                              style: TextStyle(
                                                color: colorScheme.onSurface,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : colorScheme.onSurface,
                                    ),
                                    onPressed: () =>
                                        _toggleFavorite(recipeId, isFavorite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}