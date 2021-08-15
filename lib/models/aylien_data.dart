//    from https://app.quicktype.io/ with some amount of editing required
//     final aylienData = aylienDataFromJson(jsonString);

//    A lot of things were "patched", this is an error prone area

import 'package:meta/meta.dart';
import 'dart:convert';

AylienData aylienDataFromJson(String str) =>
    AylienData.fromJson(json.decode(str));

String aylienDataToJson(AylienData data) => json.encode(data.toJson());

class AylienData {
  AylienData({
    required this.nextPageCursor,
    required this.stories,
    required this.publishedAtStart,
  });

  String nextPageCursor;
  List<Story> stories;
  DateTime publishedAtStart;

  factory AylienData.fromJson(Map<String, dynamic> json) => AylienData(
        nextPageCursor: json["next_page_cursor"],
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        publishedAtStart: DateTime.parse(json["published_at.start"]),
      );

  Map<String, dynamic> toJson() => {
        "next_page_cursor": nextPageCursor,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "published_at.start": publishedAtStart.toIso8601String(),
      };
}

class Story {
  Story({
    required this.author,
    required this.body,
    required this.categories,
    required this.charactersCount,
    required this.clusters,
    required this.entities,
    required this.hashtags,
    required this.id,
    required this.keywords,
    required this.language,
    required this.links,
    required this.media,
    required this.paragraphsCount,
    required this.publishedAt,
    required this.sentencesCount,
    required this.sentiment,
    required this.socialSharesCount,
    required this.source,
    required this.summary,
    required this.title,
    required this.wordsCount,
    required this.licenseType,
    required this.translations,
  });

  Author author;
  String body;
  List<Category> categories;
  int charactersCount;
  List<int> clusters;
  Entities entities;
  List<String> hashtags;
  int id;
  List<String> keywords;
  String language;
  StoryLinks links;
  List<Media> media;
  int paragraphsCount;
  DateTime publishedAt;
  int sentencesCount;
  StorySentiment sentiment;
  SocialSharesCount socialSharesCount;
  Source source;
  Summary summary;
  String title;
  int wordsCount;
  int licenseType;
  Translations? translations;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        author: Author.fromJson(json["author"]),
        body: json["body"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        charactersCount: json["characters_count"],
        clusters: List<int>.from(json["clusters"].map((x) => x)),
        entities: Entities.fromJson(json["entities"]),
        hashtags: List<String>.from(json["hashtags"].map((x) => x)),
        id: json["id"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        language: json["language"],
        links: StoryLinks.fromJson(json["links"]),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        paragraphsCount: json["paragraphs_count"],
        publishedAt: DateTime.parse(json["published_at"]),
        sentencesCount: json["sentences_count"],
        sentiment: StorySentiment.fromJson(json["sentiment"]),
        socialSharesCount:
            SocialSharesCount.fromJson(json["social_shares_count"]),
        source: Source.fromJson(json["source"]),
        summary: Summary.fromJson(json["summary"]),
        title: json["title"],
        wordsCount: json["words_count"],
        licenseType: json["license_type"],
        translations: json["translations"] == null
            ? null
            : Translations.fromJson(json["translations"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "body": body,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "characters_count": charactersCount,
        "clusters": List<dynamic>.from(clusters.map((x) => x)),
        "entities": entities.toJson(),
        "hashtags": List<dynamic>.from(hashtags.map((x) => x)),
        "id": id,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "language": language,
        "links": links.toJson(),
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "paragraphs_count": paragraphsCount,
        "published_at": publishedAt.toIso8601String(),
        "sentences_count": sentencesCount,
        "sentiment": sentiment.toJson(),
        "social_shares_count": socialSharesCount.toJson(),
        "source": source.toJson(),
        "summary": summary.toJson(),
        "title": title,
        "words_count": wordsCount,
        "license_type": licenseType,
        "translations": translations == null ? null : translations!.toJson(),
      };
}

class Author {
  Author({
    required this.id,
    required this.name,
  });

  int id;
  Name? name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
      };
}

enum Name { EMPTY, DAN_HAYGARTH, NAME }

final nameValues = EnumValues({
  "Dan Haygarth": Name.DAN_HAYGARTH,
  "": Name.EMPTY,
  "هيثم حسان": Name.NAME
});

class Category {
  Category({
    required this.confident,
    required this.id,
    required this.label,
    required this.level,
    required this.links,
    required this.score,
    required this.taxonomy,
  });

  bool confident;
  String id;
  String label;
  int level;
  CategoryLinks links;
  double score;
  Taxonomy? taxonomy;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        confident: json["confident"],
        id: json["id"],
        label: json["label"],
        level: json["level"],
        links: CategoryLinks.fromJson(json["links"]),
        score: json["score"].toDouble(),
        taxonomy: taxonomyValues.map[json["taxonomy"]],
      );

  Map<String, dynamic> toJson() => {
        "confident": confident,
        "id": id,
        "label": label,
        "level": level,
        "links": links.toJson(),
        "score": score,
        "taxonomy": taxonomyValues.reverse[taxonomy],
      };
}

class CategoryLinks {
  CategoryLinks({
    required this.parent,
    required this.self,
  });

  String parent;
  String self;

  factory CategoryLinks.fromJson(Map<String, dynamic> json) => CategoryLinks(
        parent: json["parent"] == null ? null : json["parent"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "parent": parent == null ? null : parent,
        "self": self,
      };
}

enum Taxonomy { IAB_QAG, IPTC_SUBJECTCODE }

final taxonomyValues = EnumValues({
  "iab-qag": Taxonomy.IAB_QAG,
  "iptc-subjectcode": Taxonomy.IPTC_SUBJECTCODE
});

class Entities {
  Entities({
    required this.body,
    required this.title,
  });

  List<BodyElement> body;
  List<BodyElement> title;

  factory Entities.fromJson(Map<String, dynamic> json) => Entities(
        body: List<BodyElement>.from(
            json["body"].map((x) => BodyElement.fromJson(x))),
        title: List<BodyElement>.from(
            json["title"].map((x) => BodyElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
      };
}

class BodyElement {
  BodyElement({
    required this.id,
    required this.types,
    required this.sentiment,
    required this.surfaceForms,
    required this.links,
    required this.stockTicker,
  });

  String id;
  List<String>? types;
  BodySentiment sentiment;
  List<SurfaceForm> surfaceForms;
  BodyLinks? links;
  String stockTicker;

  factory BodyElement.fromJson(Map<String, dynamic> json) => BodyElement(
        id: json["id"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
        sentiment: BodySentiment.fromJson(json["sentiment"]),
        surfaceForms: List<SurfaceForm>.from(
            json["surface_forms"].map((x) => SurfaceForm.fromJson(x))),
        links: json["links"] == null ? null : BodyLinks.fromJson(json["links"]),
        stockTicker: json["stock_ticker"] == null ? null : json["stock_ticker"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
        "sentiment": sentiment.toJson(),
        "surface_forms":
            List<dynamic>.from(surfaceForms.map((x) => x.toJson())),
        "links": links == null ? null : links!.toJson(),
        "stock_ticker": stockTicker == null ? null : stockTicker,
      };
}

class BodyLinks {
  BodyLinks({
    required this.wikipedia,
    required this.wikidata,
  });

  String wikipedia;
  String wikidata;

  factory BodyLinks.fromJson(Map<String, dynamic> json) => BodyLinks(
        wikipedia: json["wikipedia"],
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toJson() => {
        "wikipedia": wikipedia,
        "wikidata": wikidata,
      };
}

class BodySentiment {
  BodySentiment({
    required this.polarity,
    required this.confidence,
  });

  Polarity? polarity;
  double confidence;

  factory BodySentiment.fromJson(Map<String, dynamic> json) => BodySentiment(
        polarity: polarityValues.map[json["polarity"]],
        confidence: json["confidence"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "polarity": polarityValues.reverse[polarity],
        "confidence": confidence,
      };
}

enum Polarity { POSITIVE, NEUTRAL, NEGATIVE }

final polarityValues = EnumValues({
  "negative": Polarity.NEGATIVE,
  "neutral": Polarity.NEUTRAL,
  "positive": Polarity.POSITIVE
});

class SurfaceForm {
  SurfaceForm({
    required this.text,
    required this.indices,
  });

  String text;
  List<List<int>> indices;

  factory SurfaceForm.fromJson(Map<String, dynamic> json) => SurfaceForm(
        text: json["text"],
        indices: List<List<int>>.from(
            json["indices"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "indices": List<dynamic>.from(
            indices.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class StoryLinks {
  StoryLinks({
    required this.permalink,
    required this.relatedStories,
    required this.clusters,
  });

  String permalink;
  String relatedStories;
  String clusters;

  factory StoryLinks.fromJson(Map<String, dynamic> json) => StoryLinks(
        permalink: json["permalink"],
        relatedStories: json["related_stories"],
        clusters: json["clusters"] == null ? null : json["clusters"],
      );

  Map<String, dynamic> toJson() => {
        "permalink": permalink,
        "related_stories": relatedStories,
        "clusters": clusters == null ? null : clusters,
      };
}

class Media {
  Media({
    required this.contentLength,
    required this.format,
    required this.height,
    required this.type,
    required this.url,
    required this.width,
  });

  int contentLength;
  Format? format;
  int height;
  Type? type;
  String url;
  int width;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        contentLength:
            json["content_length"] == null ? null : json["content_length"],
        format: formatValues.map[json["format"]],
        height: json["height"],
        type: typeValues.map[json["type"]],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "content_length": contentLength == null ? null : contentLength,
        "format": formatValues.reverse[format],
        "height": height,
        "type": typeValues.reverse[type],
        "url": url,
        "width": width,
      };
}

enum Format { PNG, JPEG, WEBP }

final formatValues =
    EnumValues({"JPEG": Format.JPEG, "PNG": Format.PNG, "WEBP": Format.WEBP});

enum Type { IMAGE }

final typeValues = EnumValues({"image": Type.IMAGE});

class StorySentiment {
  StorySentiment({
    required this.body,
    required this.title,
  });

  SentimentBody body;
  SentimentBody title;

  factory StorySentiment.fromJson(Map<String, dynamic> json) => StorySentiment(
        body: SentimentBody.fromJson(json["body"]),
        title: SentimentBody.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body.toJson(),
        "title": title.toJson(),
      };
}

class SentimentBody {
  SentimentBody({
    required this.polarity,
    required this.score,
  });

  Polarity? polarity;
  double score;

  factory SentimentBody.fromJson(Map<String, dynamic> json) => SentimentBody(
        polarity: polarityValues.map[json["polarity"]],
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "polarity": polarityValues.reverse[polarity],
        "score": score,
      };
}

class SocialSharesCount {
  SocialSharesCount({
    required this.facebook,
    required this.googlePlus,
    required this.linkedin,
    required this.reddit,
  });

  List<dynamic> facebook;
  List<dynamic> googlePlus;
  List<dynamic> linkedin;
  List<dynamic> reddit;

  factory SocialSharesCount.fromJson(Map<String, dynamic> json) =>
      SocialSharesCount(
        facebook: List<dynamic>.from(json["facebook"].map((x) => x)),
        googlePlus: List<dynamic>.from(json["google_plus"].map((x) => x)),
        linkedin: List<dynamic>.from(json["linkedin"].map((x) => x)),
        reddit: List<dynamic>.from(json["reddit"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "facebook": List<dynamic>.from(facebook.map((x) => x)),
        "google_plus": List<dynamic>.from(googlePlus.map((x) => x)),
        "linkedin": List<dynamic>.from(linkedin.map((x) => x)),
        "reddit": List<dynamic>.from(reddit.map((x) => x)),
      };
}

class Source {
  Source({
    required this.domain,
    required this.homePageUrl,
    required this.id,
    required this.locations,
    required this.logoUrl,
    required this.name,
    required this.rankings,
    required this.scopes,
  });

  String domain;
  String homePageUrl;
  int id;
  List<Location> locations;
  String logoUrl;
  String name;
  Rankings? rankings;
  List<Scope> scopes;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        domain: json["domain"],
        homePageUrl: json["home_page_url"],
        id: json["id"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        logoUrl: json["logo_url"] == null ? null : json["logo_url"],
        name: json["name"],
        rankings: json["rankings"] == null
            ? null
            : Rankings.fromJson(json["rankings"]),
        scopes: List<Scope>.from(json["scopes"].map((x) => Scope.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "home_page_url": homePageUrl,
        "id": id,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "logo_url": logoUrl == null ? null : logoUrl,
        "name": name,
        "rankings": rankings == null ? null : rankings!.toJson(),
        "scopes": List<dynamic>.from(scopes.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.country,
    required this.city,
  });

  String country;
  String city;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        country: json["country"],
        city: json["city"] == null ? null : json["city"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city == null ? null : city,
      };
}

class Rankings {
  Rankings({
    required this.alexa,
  });

  List<Alexa> alexa;

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(
        alexa: List<Alexa>.from(json["alexa"].map((x) => Alexa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "alexa": List<dynamic>.from(alexa.map((x) => x.toJson())),
      };
}

class Alexa {
  Alexa({
    required this.fetchedAt,
    required this.rank,
    required this.country,
  });

  DateTime fetchedAt;
  int rank;
  String country;

  factory Alexa.fromJson(Map<String, dynamic> json) => Alexa(
        fetchedAt: DateTime.parse(json["fetched_at"]),
        rank: json["rank"],
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toJson() => {
        "fetched_at": fetchedAt.toIso8601String(),
        "rank": rank,
        "country": country == null ? null : country,
      };
}

class Scope {
  Scope({
    required this.city,
    required this.country,
    required this.level,
  });

  String city;
  String country;
  String level;

  factory Scope.fromJson(Map<String, dynamic> json) => Scope(
        city: json["city"],
        country: json["country"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "level": level,
      };
}

class Summary {
  Summary({
    required this.sentences,
  });

  List<String> sentences;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        sentences: List<String>.from(json["sentences"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sentences": List<dynamic>.from(sentences.map((x) => x)),
      };
}

class Translations {
  Translations({
    required this.en,
  });

  En en;

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        en: En.fromJson(json["en"]),
      );

  Map<String, dynamic> toJson() => {
        "en": en.toJson(),
      };
}

class En {
  En({
    required this.body,
    required this.title,
  });

  String body;
  String title;

  factory En.fromJson(Map<String, dynamic> json) => En(
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
