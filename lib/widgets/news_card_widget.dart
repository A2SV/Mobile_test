
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme_constants.dart';
import 'package:flutter_news_app/models/new_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });

  final NewModel news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
        child: ListTile(
          title: Text(
            news.title,
            style: const TextStyle(
              color: ThemeConstants.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.10,
            ),
          ),
          subtitle: Text(
            news.description,
            style: const TextStyle(
              color: ThemeConstants.secondaryColorLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            softWrap: true,
            maxLines: 6,
            overflow: TextOverflow.ellipsis
          ),
          leading: Image.network(
            news.urlToImage,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
