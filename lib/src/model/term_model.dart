class Term {
  final int termID;
  final String termName, termTimeFrom, termTimeTo;

  Term({this.termID, this.termName, this.termTimeFrom, this.termTimeTo});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      termID: json['termId'],
      termTimeFrom: json['termTimeFrom'],
      termTimeTo: json['termTimeTo'],
      termName: json['termName'],
    );
  }

}

class TermList {
  List<Term> termList;

  TermList({this.termList});

  factory TermList.fromJson(List<dynamic> parsedJson){

    List<Term> terms = new List<Term>();

    terms = parsedJson.map((i) => Term.fromJson(i)).toList();

    return new TermList(
      termList: terms,
    );
  }
}
