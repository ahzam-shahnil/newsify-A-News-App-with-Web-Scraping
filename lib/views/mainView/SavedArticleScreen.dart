// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:newsify/model/top_story.dart';
import 'package:newsify/widgets/NewsGrid.dart';
import '../../service/Dbhelper.dart';

class SavedArticleScreen extends StatefulWidget {
  @override
  _SavedArticleScreenState createState() => _SavedArticleScreenState();
}

class _SavedArticleScreenState extends State<SavedArticleScreen> {
  bool isFocused = false;

  // to check if the search is empty
  bool isSearchEmpty = true;

  final DbHelper _dbHelper = DbHelper();
  late TextEditingController _searchController;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchController = TextEditingController();

    _searchController.addListener(_setLatestSearch);
    super.initState();
  }

  _setLatestSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: isFocused != true
            ? const Text(
                'Saved Articles',
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        autofocus: isFocused,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => setState(() {
              isFocused = true;
            }),
          ),
        ],
      ),

      //? Here the body of saved article screen start
      body: WillPopScope(
        onWillPop: () async {
          if (isFocused) {
            setState(() {
              isFocused = false;
            });
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: FutureBuilder(
            future: isSearchEmpty
                ? _dbHelper.queryAll()
                : _dbHelper.queryOnly(_searchController.text.trim()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<TopStory> article = snapshot.data;
                return NewsGrid(article: article);
              } else {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
