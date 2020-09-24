class Posts {
  int id;
  String date;
  String modified;
  String modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Title title;
  Content content;
  int author;
  int featuredMedia;
  List<int> categories;
  List<int> tags;
  String jetpackFeaturedMediaUrl;
  Embedded eEmbedded;

  Posts(
      {this.id,
      this.date,
      this.modified,
      this.modifiedGmt,
      this.slug,
      this.status,
      this.type,
      this.link,
      this.title,
      this.content,
      this.author,
      this.featuredMedia,
      this.categories,
      this.tags,
      this.jetpackFeaturedMediaUrl,
      this.eEmbedded});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    categories = json['categories'].cast<int>();
    tags = json['tags'].cast<int>();
    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['author'] = this.author;
    data['featured_media'] = this.featuredMedia;
    data['categories'] = this.categories;
    data['tags'] = this.tags;
    data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;
    if (this.eEmbedded != null) {
      data['_embedded'] = this.eEmbedded.toJson();
    }
    return data;
  }
}

class Title {
  String rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  String rendered;
  bool protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Embedded {
  List<Author> author;

  Embedded({this.author});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['author'] != null) {
      author = new List<Author>();
      json['author'].forEach((v) {
        author.add(new Author.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Author {
  int id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  AvatarUrls avatarUrls;

  Author(
      {this.id,
      this.name,
      this.url,
      this.description,
      this.link,
      this.slug,
      this.avatarUrls});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    description = json['description'];
    link = json['link'];
    slug = json['slug'];
    avatarUrls = json['avatar_urls'] != null
        ? new AvatarUrls.fromJson(json['avatar_urls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['description'] = this.description;
    data['link'] = this.link;
    data['slug'] = this.slug;
    if (this.avatarUrls != null) {
      data['avatar_urls'] = this.avatarUrls.toJson();
    }
    return data;
  }
}

class AvatarUrls {
  String s24;
  String s48;
  String s96;

  AvatarUrls({this.s24, this.s48, this.s96});

  AvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
    s48 = json['48'];
    s96 = json['96'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.s24;
    data['48'] = this.s48;
    data['96'] = this.s96;
    return data;
  }
}
