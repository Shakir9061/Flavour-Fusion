import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/profile/newchefprofile.dart';
import 'package:flutter/material.dart';

import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/view/Home/notifications.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({super.key});

  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome> {
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
          .collection('ChefAuth')
          .doc(user.uid)
          .get();

      setState(() {
        _profileImageUrl = userData['profileImage'];
      });
    }
  }

  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(0, 80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Color(0xff1D1B20),
            automaticallyImplyLeading: false,
            leading:  Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => chef_profilePage(),
                            ));
                      },
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: _profileImageUrl != null
                            ? NetworkImage(_profileImageUrl!)
                            : null,
                        child:
                            _profileImageUrl == null ? Icon(Icons.person) : null,
                      ),
                    ),
            ),
                  actions: [
                    Padding(
                      padding:  EdgeInsets.only(right: 10.w),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notificationchef(),
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
            title:Text('Flavour Fusion',style: GoogleFonts.dancingScript(fontSize: 35,color: Colors.teal,fontWeight: FontWeight.w700),)
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
              SectionTitle('Recommended Recipes'),
              ChefRecipesShow(
                height: 250,
                width: 200,
              ),
              SectionTitle('Popular recipes'),
             PopularRecipesShow(height: 180,width: 150,),
              SectionTitle('Chef Recipes'),
              ChefRecipesShow()
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedRecipe extends StatelessWidget {
  final double? height;
  final double? width;
  RecommendedRecipe(this.height, this.width);
  @override
  Widget build(BuildContext context) {
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
                      color: Colors.grey[800],
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

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
         title,
        style: TextStyle(fontSize: 19.spMin,fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}

class ChefRecipesShow extends StatefulWidget {
  final double height;
  final double width;
  const ChefRecipesShow({Key? key, this.height = 180, this.width = 150})
      : super(key: key);

  @override
  _ChefRecipesShowState createState() => _ChefRecipesShowState();
}

class _ChefRecipesShowState extends State<ChefRecipesShow> {
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
                                builder: (context) => RecipeDetailPage_chef(
                                    recipe: recipe, recipeId: recipeId),
                              ));
                        },
                        child: Card(
                          // margin: EdgeInsets.symmetric(horizontal: 8.0),
                          color: Color(0xff1D1B20),
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
                                          color: Colors.white, fontSize: 14),
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
                                        isFavorite ? Colors.red : Colors.white,
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

class PopularRecipesShow extends StatefulWidget {
  final double height;
  final double width;

  const PopularRecipesShow({
    Key? key,
    this.height = 180.0,
    this.width = 150.0,
  }) : super(key: key);

  @override
  _PopularRecipesShowState createState() => _PopularRecipesShowState();
}

class _PopularRecipesShowState extends State<PopularRecipesShow> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> _recipesStream;
  late Stream<DocumentSnapshot> _favoritesStream;

  @override
  void initState() {
    super.initState();
    _recipesStream = _firestore
        .collection('recipes')
        .orderBy('timestamp',descending: true) 
        
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
                                builder: (context) => RecipeDetailPage_chef(
                                  recipe: recipe,
                                  recipeId: recipeId,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Color(0xff1D1B20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                                color: Colors.white,
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
                                          : Colors.white,
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
