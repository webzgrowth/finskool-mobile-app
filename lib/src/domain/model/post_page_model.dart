import 'feed_post_model.dart';

/// One page of `GET /mobile/posts`.
class PostPageModel {
  const PostPageModel({
    required this.posts,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  final List<FeedPostModel> posts;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  bool get hasMore => page < totalPages;

  factory PostPageModel.fromJson(Map<String, dynamic> json) {
    final rows = json['posts'] as List? ?? const [];
    return PostPageModel(
      posts: rows
          .map((p) => FeedPostModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int? ?? rows.length,
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? rows.length,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }
}
