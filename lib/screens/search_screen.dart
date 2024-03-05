import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/services/api_service.dart';
import 'package:flutter_news_app/widgets/home/all_news.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //write your code here
  final searchController = TextEditingController();
  var news = [];

  void fetchSearch() async {
    final searchText = searchController.text;
    final service = APIService();
    final result = await service.fetchSearch(searchQuery: searchText);
    setState(() {
      news = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      height: 10,
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: TextField(
                        controller: searchController,
                      )),
                  ElevatedButton(
                      onPressed: fetchSearch, child: Icon(Icons.search))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: MediaQuery.sizeOf(context).height * 3,
                  child: news.isNotEmpty
                      ? ListView.builder(
                          itemCount: news.length,
                          itemBuilder: (context, index) {
                            NewModel newModel = news[index];
                            return HomeNewItem(newModel: newModel);
                          },
                        )
                      : Container(
                          child: Text("There is no news "),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
