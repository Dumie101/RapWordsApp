import 'dart:convert';

List<RhymeWord> rhymeWordFromJson(String str) => List<RhymeWord>.from(json.decode(str).map((x) => RhymeWord.fromJson(x)));
String rhymeWordToJson(List<RhymeWord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RhymeWord {
  RhymeWord({
    required this.word,
    required this.score,
    required this.numSyllables,
  });

  String word;
  int? score;
  int numSyllables;

  factory RhymeWord.fromJson(Map<String, dynamic> json) => RhymeWord(
    word: json["word"],
    score: json["score"] == null ? null : json["score"],
    numSyllables: json["numSyllables"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "score": score == null ? null : score,
    "numSyllables": numSyllables,
  };
}