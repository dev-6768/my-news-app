import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsItemWidget extends StatelessWidget {
  final String imageUrl;
  final String source;
  final String description;
  final DateTime timeStamp;

  const NewsItemWidget({
    super.key,
    required this.imageUrl,
    required this.source,
    required this.description,
    required this.timeStamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  timeStamp.toIso8601String(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // News Image (Flexible to avoid hardcoding)

          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              )   
            ),
          ),
        ],
      ),
    );
  }
}