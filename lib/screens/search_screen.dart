import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme_constants.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/services/api_service.dart';
import 'package:flutter_news_app/widgets/news_card_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final APIService _apiService = APIService();
  List<NewModel> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.primaryColorLight,
      appBar: AppBar(
        backgroundColor: ThemeConstants.primaryColorLight,
        surfaceTintColor: ThemeConstants.primaryColorLight,
        title: const Text('Search News'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search news ',
                      hintStyle: const TextStyle(
                        color: ThemeConstants.hintTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 0.11,
                        letterSpacing: 0.50,
                      ),
                      contentPadding: const EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: Container(
                  width: 50,
                  height: 48,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: ThemeConstants.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    onTap: _search,
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final news = _searchResults[index];
                      return Padding(
                         padding: EdgeInsets.only(
                                bottom: index < _searchResults.length - 1 ? 10 : 0),
                            
                        child: NewsCard(news: news),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<NewModel> results = await _apiService.fetchSearch(
        searchQuery: _searchController.text,
      );
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error searching articles: $e'),
        ),
      );
    }
  }
}
