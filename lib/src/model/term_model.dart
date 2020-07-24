class Term {
  final int termID;
  final String termName, termTimeFrom, termTimeTo, termStatus;
  final double termSlice;

  Term({this.termID, this.termName, this.termSlice, this.termTimeFrom, this.termTimeTo, this.termStatus});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      termID: json['termId'],
      termTimeFrom: json['termTimeFrom'],
      termTimeTo: json['termTimeTo'],
      termName: json['termName'],
      termSlice: json['termSliceTotal'],
      termStatus: json['termStatus'],
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
