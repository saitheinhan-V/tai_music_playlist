import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {


  final cities=[
    'Myanmar','Malaysia','Singapore','Vietnam','Australia',
    'America','Burma','Hungary','Holland','Zambia','Thailand','Tanzania','Japan','Korea','Cambodia',
    'Cameron','China','Denmark','Egypt','England','Finland','France','Greece','Italy','Portugal',
    'Russia','Switzerland','Netherland','USA','Yale'
  ];
  final recentCities=[
    'Myanmar','Malaysia','Singapore','Vietnam','Burma','Australia',
  ];

  late bool hasQuery = false;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        color: Colors.grey,
        onPressed: () {
          query = '';
          hasQuery=false;
          // showResults(context);
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.grey,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Query $hasQuery');
    return hasQuery?
    Container(
      width: 100.0,
      height: 100.0,
      color: Colors.red,
      child: Center(
        child: Text(query),
      ),
    ): Container();
  }


  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty? recentCities: cities.where((p) => p.toLowerCase().contains(query)).toList();
    var showSuggestionList = suggestionList.map((e) => e.toLowerCase()).toList();
    hasQuery = query.isEmpty? false : true;
    //p.startWith(query)
    var startIndex = 0;
    var endIndex = 0;
    var currentString = '';
    print('Suggestion >>> $suggestionList');

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context,int index){
        currentString = showSuggestionList[index];
        startIndex = hasQuery? currentString.indexOf(query,0) : 0;
        endIndex = startIndex + query.length;
        print("Start >> $startIndex >> End $endIndex >> Value ${showSuggestionList[index].indexOf('a',0)}");
        return ListTile(
          onTap: (){
            query=suggestionList[index];
            hasQuery=true;
            !recentCities.contains(suggestionList[index]) ? recentCities.add(suggestionList[index]) : null;
            showResults(context);
          },
          leading: const Icon(Icons.location_city),
          title: hasQuery ? RichText(
            text: startIndex==0 ? TextSpan(
              text: suggestionList[index].substring(startIndex,endIndex),
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              children: [
                suggestionList[index].length> endIndex ? TextSpan(
                  text: suggestionList[index].substring(endIndex,suggestionList[index].length),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ) : const TextSpan(text: ""),
              ],
            ) : TextSpan(
              text: suggestionList[index].substring(0,startIndex),
              style: const TextStyle(
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(startIndex,endIndex),
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                suggestionList[index].length > endIndex ? TextSpan(
                  text: suggestionList[index].substring(endIndex,suggestionList[index].length),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ) : const TextSpan(
                  text: ''
                )
              ]
            ),
          )
          : RichText(
              text: TextSpan(
                text: suggestionList[index],
                style: const TextStyle(
                    color: Colors.grey,
                  ),
                )),
          trailing: const Icon(Icons.subdirectory_arrow_right),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.green,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
    );
  }

}