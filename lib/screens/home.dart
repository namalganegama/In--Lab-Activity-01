import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/constants/colors.dart';
import '../models/recipe.dart';
import '../widgets/recipe_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tasks = Recipe.recipeList();
  final _recipeController = TextEditingController();

  //define firebase Database Reference to add data
  late DatabaseReference dbRef;
  //define firebase Database Reference to fetch data
  Query dbQuery = FirebaseDatabase.instance.ref().child('Recipes');

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Recipes');
  }

  Widget listItem({required Map task}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['item'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

//Define the app body in scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBrown,
      appBar: _appBarWidget(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Recipe List',
                      style: TextStyle(
                        color: textBlack,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: dbQuery,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map task = snapshot.value as Map;

                task['key'] = snapshot.key;
                return listItem(item: item);
              },
            ),
          ),
//Get recipe input
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 18.0,
                      bottom: 20.0,
                    ),
                    child: TextField(
                      controller: _recipeController,
                      decoration: const InputDecoration(
                        hintText: 'Add Title',
                        helperStyle: TextStyle(
                          color: textBlack,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    child: TextField(
                      controller: _recipeController,
                      decoration: const InputDecoration(
                        hintText: 'Add Description',
                        helperStyle: TextStyle(
                          color: textBlack,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    child: TextField(
                      controller: _recipeController,
                      decoration: const InputDecoration(
                        hintText: 'Add Ingrediants',
                        helperStyle: TextStyle(
                          color: textBlack,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: bgBlue,
                    //add task to database
                    onPressed: () {
                      Map<String, String> items = {
                        'item': _itemController.text,
                        'description': _itemController.text,
                        'ingrediants': _itemController.text,
                      };
                      dbRef.push().set(tasks);
                      _onAddItem(_itemController.text);
                    },
                    child: const Icon(
                      Icons.add,
                      color: textWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Define the appbar on the top
  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: bgBlue,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: textWhite,
            size: 30,
          ),
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChangeItem(Recipe recipe) {
    setState(() {
      if (task.isDone == 1) {
        task.isDone = 0;
      } else {
        task.isDone = 1;
      }
    });
  }

  void _onDeleteItem(String id) {
    setState(() {
      tasks.removeWhere((element) => element.id == id);
    });
  }

  void _onAddItem(String title) {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add(Recipe(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          isDone: 0,
        ));
      });
    } else {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter a recipe'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    _recipeController.clear();
  }
}
