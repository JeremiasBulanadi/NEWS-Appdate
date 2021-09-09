//  Made after the damn AYLIEN API structure update

//    from https://app.quicktype.io/ with some amount of editing required
//    A lot of things were "patched", this is an error prone area

//  This code just parses/maps the json response into actual json data
//  with the exception of the getNewsLocation function
//  I will not elaborate further cuz there's too much here to explain

import 'package:news_appdate/models/location.dart';
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
  List<Story>? stories;
  DateTime? publishedAtStart;

  factory AylienData.fromJson(Map<String, dynamic> json) => AylienData(
        nextPageCursor:
            json["next_page_cursor"] == null ? null : json["next_page_cursor"],
        stories: json["stories"] == null
            ? null
            : List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        publishedAtStart: json["published_at.start"] == null
            ? null
            : DateTime.parse(json["published_at.start"]),
      );

  Map<String, dynamic> toJson() => {
        "next_page_cursor": nextPageCursor == null ? null : nextPageCursor,
        "stories": stories == null
            ? null
            : List<dynamic>.from(stories!.map((x) => x.toJson())),
        "published_at.start": publishedAtStart == null
            ? null
            : publishedAtStart!.toIso8601String(),
      };

  // What you may see before you may seem like a big hot mess
  // and you would be correct
  // but rejoice, as this single function alone
  // has made me decide to fully comment on every what, why, and how
  // of every snippet of madness that is in this codebase
  // This one is not from app.quicktype.io
  // This function gets entities that "might" be the location of the news...
  // and instantiates them as Location objects to be stored in each Story object
  Future<void> getNewsLocations() async {
    // Iteratates through all the news stories
    for (int i = 0; i < this.stories!.length; i++) {
      // temporary storage for possible locations
      List<Loc> locations = [];

      // Iterattes through all entities in the news story
      for (int j = 0; j < this.stories![i].entities!.length; j++) {
        // for debugging purposes, might delete later
        //print(this.stories![i].entities![j].types);

        // sometimes entities don't have types, this is a workaround null checker
        if (this.stories![i].entities![j].types == null) {
          print("Type list is null");
        } else if (isSpecificLocation(this.stories![i].entities![j].types)) {
          // Gotta have this
          if (this.stories![i].entities![j].body!.surfaceForms!.length > 0) {
            // For debugging purposes, really fills up the console, will probs delete
            // print(this.stories![i].entities![j].body!.surfaceForms![0].text);

            // Instantiates the filtered entity and stores it in the locations array
            locations.add(
                Loc(this.stories![i].entities![j].body!.surfaceForms![0].text));
          }
        }
      }
      // adds the locations values for the story's locations property
      this.stories![i].locations = locations == null ? [] : locations;
    }
  }
}

// Filters depending on the what type we want to include/exclude
bool isSpecificLocation(List<String>? types) {
  return // We're trying to get entities that...
      // ...have "Location" as a type
      types!.contains("Location") &&
          // ...is not a country (We don't want a marker on the country)
          (!types.contains("Country") &&
              // ? Cities maybe too much ?
              !types.contains("City") &&
              // ...is not a state (States are too broad of a location)
              !types.contains("State_(polity)") &&
              // ...is not a Sovereign State (I still am not entirely sure what a sovereign state is but it is still, for the most part, broad)
              !types.contains("Sovereign_state"));
}

class Story {
  Story({
    required this.author,
    required this.body,
    required this.categories,
    required this.industries,
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
  });

  Author? author;
  String? body;
  List<Category>? categories;
  List<dynamic>? industries;
  int charactersCount;
  List<int>? clusters;
  List<Entity>? entities;
  List<String>? hashtags;
  int id;
  List<String>? keywords;
  String language;
  StoryLinks? links;
  List<Media>? media;
  int paragraphsCount;
  DateTime? publishedAt;
  int sentencesCount;
  StorySentiment? sentiment;
  SocialSharesCount? socialSharesCount;
  Source? source;
  Summary? summary;
  String title;
  int wordsCount;
  int licenseType;
  // below are not from AYLIEN API
  List<Loc>? locations;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        author: Author.fromJson(json["author"]),
        body: json["body"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        industries: List<dynamic>.from(json["industries"].map((x) => x)),
        charactersCount: json["characters_count"],
        clusters: List<int>.from(json["clusters"].map((x) => x)),
        entities:
            List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x))),
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
      );

  Map<String, dynamic> toJson() => {
        "author": author!.toJson(),
        "body": body,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "industries": List<dynamic>.from(industries!.map((x) => x)),
        "characters_count": charactersCount,
        "clusters": List<dynamic>.from(clusters!.map((x) => x)),
        "entities": List<dynamic>.from(entities!.map((x) => x.toJson())),
        "hashtags": List<dynamic>.from(hashtags!.map((x) => x)),
        "id": id,
        "keywords": List<dynamic>.from(keywords!.map((x) => x)),
        "language": language,
        "links": links!.toJson(),
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "paragraphs_count": paragraphsCount,
        "published_at": publishedAt!.toIso8601String(),
        "sentences_count": sentencesCount,
        "sentiment": sentiment!.toJson(),
        "social_shares_count": socialSharesCount!.toJson(),
        "source": source!.toJson(),
        "summary": summary!.toJson(),
        "title": title,
        "words_count": wordsCount,
        "license_type": licenseType,
      };
}

class Author {
  Author({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Category {
  Category({
    required this.confident,
    required this.id,
    required this.label,
    required this.level,
    required this.score,
    required this.taxonomy,
    required this.links,
  });

  bool confident;
  String? id;
  String? label;
  int level;
  double score;
  String? taxonomy;
  CategoryLinks? links;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        confident: json["confident"],
        id: json["id"],
        label: json["label"],
        level: json["level"],
        score: json["score"].toDouble(),
        taxonomy: json["taxonomy"],
        links: CategoryLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "confident": confident,
        "id": id,
        "label": label,
        "level": level,
        "score": score,
        "taxonomy": taxonomy,
        "links": links!.toJson(),
      };
}

class CategoryLinks {
  CategoryLinks({
    required this.parent,
    required this.self,
  });

  String? parent;
  String? self;

  factory CategoryLinks.fromJson(Map<String, dynamic> json) => CategoryLinks(
        parent: json["parent"] == null ? null : json["parent"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "parent": parent == null ? null : parent,
        "self": self,
      };
}

class Entity {
  Entity({
    required this.id,
    required this.links,
    required this.stockTickers,
    required this.types,
    required this.overallSentiment,
    required this.overallProminence,
    required this.overallFrequency,
    required this.body,
    required this.title,
  });

  String id;
  EntityLinks? links;
  List<String>? stockTickers;
  List<String>? types;
  OverallSentimentClass? overallSentiment;
  double overallProminence;
  int overallFrequency;
  EntityBody? body;
  EntityBody? title;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["id"],
        links:
            json["links"] == null ? null : EntityLinks.fromJson(json["links"]),
        stockTickers: List<String>.from(json["stock_tickers"].map((x) => x)),
        types: List<String>.from(json["types"].map((x) => x)),
        overallSentiment:
            OverallSentimentClass.fromJson(json["overall_sentiment"]),
        overallProminence: json["overall_prominence"].toDouble(),
        overallFrequency: json["overall_frequency"],
        body: EntityBody.fromJson(json["body"]),
        title: EntityBody.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "links": links == null ? null : links!.toJson(),
        "stock_tickers": List<dynamic>.from(stockTickers!.map((x) => x)),
        "types": List<dynamic>.from(types!.map((x) => x)),
        "overall_sentiment": overallSentiment!.toJson(),
        "overall_prominence": overallProminence,
        "overall_frequency": overallFrequency,
        "body": body!.toJson(),
        "title": title!.toJson(),
      };
}

class EntityBody {
  EntityBody({
    required this.sentiment,
    required this.surfaceForms,
  });

  OverallSentimentClass? sentiment;
  List<SurfaceForm>? surfaceForms;

  factory EntityBody.fromJson(Map<String, dynamic> json) => EntityBody(
        sentiment: json["sentiment"] == null
            ? null
            : OverallSentimentClass.fromJson(json["sentiment"]),
        surfaceForms: List<SurfaceForm>.from(
            json["surface_forms"].map((x) => SurfaceForm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sentiment": sentiment == null ? null : sentiment!.toJson(),
        "surface_forms":
            List<dynamic>.from(surfaceForms!.map((x) => x.toJson())),
      };
}

class OverallSentimentClass {
  OverallSentimentClass({
    required this.polarity,
    required this.confidence,
  });

  String polarity;
  double confidence;

  factory OverallSentimentClass.fromJson(Map<String, dynamic> json) =>
      OverallSentimentClass(
        polarity: json["polarity"],
        confidence: json["confidence"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "polarity": polarity,
        "confidence": confidence,
      };
}

class SurfaceForm {
  SurfaceForm({
    required this.text,
    required this.frequency,
    required this.mentions,
  });

  String text;
  int frequency;
  List<Mention>? mentions;

  factory SurfaceForm.fromJson(Map<String, dynamic> json) => SurfaceForm(
        text: json["text"],
        frequency: json["frequency"],
        mentions: List<Mention>.from(
            json["mentions"].map((x) => Mention.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "frequency": frequency,
        "mentions": List<dynamic>.from(mentions!.map((x) => x.toJson())),
      };
}

class Mention {
  Mention({
    required this.index,
    required this.sentiment,
  });

  Index? index;
  OverallSentimentClass? sentiment;

  factory Mention.fromJson(Map<String, dynamic> json) => Mention(
        index: Index.fromJson(json["index"]),
        sentiment: OverallSentimentClass.fromJson(json["sentiment"]),
      );

  Map<String, dynamic> toJson() => {
        "index": index!.toJson(),
        "sentiment": sentiment!.toJson(),
      };
}

class Index {
  Index({
    required this.start,
    required this.end,
  });

  int start;
  int end;

  factory Index.fromJson(Map<String, dynamic> json) => Index(
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
      };
}

class EntityLinks {
  EntityLinks({
    required this.wikipedia,
    required this.wikidata,
  });

  String? wikipedia;
  String? wikidata;

  factory EntityLinks.fromJson(Map<String, dynamic> json) => EntityLinks(
        wikipedia: json["wikipedia"],
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toJson() => {
        "wikipedia": wikipedia,
        "wikidata": wikidata,
      };
}

class StoryLinks {
  StoryLinks({
    required this.permalink,
    required this.relatedStories,
    required this.clusters,
  });

  String? permalink;
  String? relatedStories;
  String? clusters;

  factory StoryLinks.fromJson(Map<String, dynamic> json) => StoryLinks(
        permalink: json["permalink"],
        relatedStories: json["related_stories"],
        clusters: json["clusters"],
      );

  Map<String, dynamic> toJson() => {
        "permalink": permalink,
        "related_stories": relatedStories,
        "clusters": clusters,
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

  int? contentLength;
  String? format;
  int? height;
  String? type;
  String? url;
  int? width;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        contentLength: json["content_length"],
        format: json["format"],
        height: json["height"],
        type: json["type"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "content_length": contentLength,
        "format": format,
        "height": height,
        "type": type,
        "url": url,
        "width": width,
      };
}

class StorySentiment {
  StorySentiment({
    required this.body,
    required this.title,
  });

  SentimentBody? body;
  SentimentBody? title;

  factory StorySentiment.fromJson(Map<String, dynamic> json) => StorySentiment(
        body: SentimentBody.fromJson(json["body"]),
        title: SentimentBody.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body!.toJson(),
        "title": title!.toJson(),
      };
}

class SentimentBody {
  SentimentBody({
    required this.polarity,
    required this.score,
  });

  String polarity;
  double score;

  factory SentimentBody.fromJson(Map<String, dynamic> json) => SentimentBody(
        polarity: json["polarity"],
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "polarity": polarity,
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

  List<dynamic>? facebook;
  List<dynamic>? googlePlus;
  List<dynamic>? linkedin;
  List<dynamic>? reddit;

  factory SocialSharesCount.fromJson(Map<String, dynamic> json) =>
      SocialSharesCount(
        facebook: List<dynamic>.from(json["facebook"].map((x) => x)),
        googlePlus: List<dynamic>.from(json["google_plus"].map((x) => x)),
        linkedin: List<dynamic>.from(json["linkedin"].map((x) => x)),
        reddit: List<dynamic>.from(json["reddit"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "facebook": List<dynamic>.from(facebook!.map((x) => x)),
        "google_plus": List<dynamic>.from(googlePlus!.map((x) => x)),
        "linkedin": List<dynamic>.from(linkedin!.map((x) => x)),
        "reddit": List<dynamic>.from(reddit!.map((x) => x)),
      };
}

class Source {
  Source({
    required this.domain,
    required this.homePageUrl,
    required this.id,
    required this.locations,
    required this.name,
    required this.rankings,
    required this.scopes,
    required this.logoUrl,
  });

  String domain;
  String homePageUrl;
  int id;
  List<Location>? locations;
  String name;
  Rankings? rankings;
  List<Scope>? scopes;
  String? logoUrl;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        domain: json["domain"],
        homePageUrl: json["home_page_url"],
        id: json["id"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        name: json["name"],
        rankings: json["rankings"] == null
            ? null
            : Rankings.fromJson(json["rankings"]),
        scopes: List<Scope>.from(json["scopes"].map((x) => Scope.fromJson(x))),
        logoUrl: json["logo_url"] == null ? null : json["logo_url"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "home_page_url": homePageUrl,
        "id": id,
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "name": name,
        "rankings": rankings == null ? null : rankings!.toJson(),
        "scopes": List<dynamic>.from(scopes!.map((x) => x.toJson())),
        "logo_url": logoUrl == null ? null : logoUrl,
      };
}

class Location {
  Location({
    required this.city,
    required this.country,
    required this.state,
  });

  String? city;
  String country;
  String? state;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"] == null ? null : json["city"],
        country: json["country"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "country": country,
        "state": state == null ? null : state,
      };
}

class Rankings {
  Rankings({
    required this.alexa,
  });

  List<Alexa>? alexa;

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(
        alexa: List<Alexa>.from(json["alexa"].map((x) => Alexa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "alexa": List<dynamic>.from(alexa!.map((x) => x.toJson())),
      };
}

class Alexa {
  Alexa({
    required this.fetchedAt,
    required this.rank,
    required this.country,
  });

  DateTime? fetchedAt;
  int rank;
  String? country;

  factory Alexa.fromJson(Map<String, dynamic> json) => Alexa(
        fetchedAt: DateTime.parse(json["fetched_at"]),
        rank: json["rank"],
        country: json["country"] == null ? null : json["country"],
      );

  Map<String, dynamic> toJson() => {
        "fetched_at": fetchedAt!.toIso8601String(),
        "rank": rank,
        "country": country == null ? null : country,
      };
}

class Scope {
  Scope({
    required this.country,
    required this.level,
  });

  String? country;
  String level;

  factory Scope.fromJson(Map<String, dynamic> json) => Scope(
        country: json["country"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "level": level,
      };
}

class Summary {
  Summary({
    required this.sentences,
  });

  List<String>? sentences;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        sentences: List<String>.from(json["sentences"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sentences": List<dynamic>.from(sentences!.map((x) => x)),
      };
}
