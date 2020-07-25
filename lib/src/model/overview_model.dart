class OverView {
  final String companyName, companyImage;
  final int totalTerm, totalStakeHolder;
  final double cashPerSlice, totalSlice;

  OverView({this.companyName, this.companyImage, this.totalSlice, this.cashPerSlice, this.totalTerm, this.totalStakeHolder});

  factory OverView.fromJson(Map<String, dynamic> json){
    return OverView(
        companyName: json['companyName'],
        companyImage: json['companyImage'],
        cashPerSlice: json['cashPerSlice'],
        totalTerm: json['totalTerm'],
        totalSlice: json['totalSlice'],
        totalStakeHolder: json['totalStakeholder'],
    );
  }
}