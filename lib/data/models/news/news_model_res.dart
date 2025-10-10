class NewsModelRes {
  int? newsId;
  String? newsHeader;
  String? newsContent;
  String? newsThumbnail;
  String? newsImage;
  String? fileAttached1;
  String? fileAttached2;
  String? fileAttached3;
  String? createDate;

  NewsModelRes.empty();

  NewsModelRes({this.newsId, this.newsHeader, this.newsContent, this.newsThumbnail, this.newsImage, this.fileAttached1, this.fileAttached2, this.fileAttached3, this.createDate});

  NewsModelRes.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsHeader = json['news_header'];
    newsContent = json['news_content'];
    newsThumbnail = json['news_thumbnail'];
    newsImage = json['news_image'];
    fileAttached1 = json['file_attached1'] ?? '';
    fileAttached2 = json['file_attached2'] ?? '';
    fileAttached3 = json['file_attached3'] ?? '';
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_header'] = this.newsHeader;
    data['news_content'] = this.newsContent;
    data['news_thumbnail'] = this.newsThumbnail;
    data['news_image'] = this.newsImage;
    data['file_attached1'] = this.fileAttached1;
    data['file_attached2'] = this.fileAttached2;
    data['file_attached3'] = this.fileAttached3;
    data['create_date'] = this.createDate;
    return data;
  }
}
