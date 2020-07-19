import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:slicingpieproject/src/view/company_contribution_detail_page.dart';
import 'package:slicingpieproject/src/viewmodel/company-history-contribute-vm.dart';
import 'package:slicingpieproject/src/viewmodel/company_contribution_detail_viewmodel.dart';

class CompanyHistoryContributePage extends StatelessWidget {
  final CompanyHistoryContributeViewModel companyHistory;

  CompanyHistoryContributePage({this.companyHistory});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CompanyHistoryContributeViewModel>(
      model: companyHistory,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("List Company Contribution"),
        ),
        body: GestureDetector(
          child: ScopedModelDescendant<CompanyHistoryContributeViewModel>(
            builder: (context, child, companyHistory) {
              if (companyHistory.isLoading == true) {
                return LoadingScreen();
              } else
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: getListContribution(context, companyHistory),
              );
            },
          ),
        ),
      ),
    );
  }

}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget getListContribution(
    BuildContext context, CompanyHistoryContributeViewModel companyHistory) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: companyHistory.listContribute.length,
    itemBuilder: (context, index) {
      return getListContributionUI(context, index, companyHistory);
    },
  );
}

Widget getListContributionUI(BuildContext context, int index,
    CompanyHistoryContributeViewModel companyHistory) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    color: (index % 2 == 0) ? Colors.white : Colors.black12,
    child: GestureDetector(
      onTap: () {
        print(companyHistory.listContribute[index].assetId);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => CompanyContributionDetailPage(
            model: CompanyContributionDetailViewModel(
                companyHistory.listContribute[index].assetId,companyHistory.listContribute[index].namePerson),),
          ),
        ).then((value) => companyHistory.getAll());
      },
      child: CustomListItemTwo(
        title: '${companyHistory.listContribute[index].typeAsset} Contribution',
        subtitle: companyHistory.listContribute[index].timeAsset,
        author: companyHistory.listContribute[index].namePerson,
        quantity: companyHistory.listContribute[index].quantity.toString(),
        project: companyHistory.listContribute[index].project,
      ),
    ),
  );
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.project,
    this.quantity,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String project;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Row(
          children: <Widget>[
            Icon(Icons.access_time,color: Colors.black54,size: 17,),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Text(
              '$subtitle',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Text(
          'Name: $author',
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Project: $project',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
            ),
            Text(
              '+$quantity',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),

      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.project,
    this.quantity,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String project;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  quantity: quantity,
                  project: project,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
