import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/featured/home/controller/news_provider.dart';
import 'package:my_news_app/featured/home/view/widget/news_item_widget.dart';

class NewsScrollViewWidget extends ConsumerStatefulWidget {
  const NewsScrollViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsScrollViewWidgetState();
}

class _NewsScrollViewWidgetState extends ConsumerState<NewsScrollViewWidget> {

  @override
  Widget build(BuildContext context) {
    final newsAsyncValue = ref.watch(newsProvider);

    return newsAsyncValue.when(
      data: (newsList) => newsList.isNotEmpty
      ? ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewsItemWidget(
              imageUrl: news.imageUrl, 
              source: news.source, 
              description: news.description, 
              timeStamp: news.timestamp,
            )
          );
        },
      )

      : Center(
        child: Text(
          "No news at this moment. try again later.",
          style: GoogleFonts.poppins(
            color: AppColors.kBlack,
            fontSize: 14,
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}