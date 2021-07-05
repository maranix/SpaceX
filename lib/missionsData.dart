import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spacex_rockets/constants.dart';

class MissionsData extends StatefulWidget {
  static final HttpLink httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  const MissionsData({Key? key}) : super(key: key);

  @override
  _MissionsDataState createState() => _MissionsDataState();
}

class _MissionsDataState extends State<MissionsData> {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: MissionsData.httpLink,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SpaceX Missions'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Query(
                options: QueryOptions(document: gql(missions)),
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  } else if (result.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF5951c9))),
                    );
                  }
                  final mission = result.data!['missions'];
                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: mission.length,
                    itemBuilder: (context, index) {
                      final missions = mission[index];
                      return Material(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(missions['name'], style: h1),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    Colors.black26,
                                    Colors.black12,
                                    Colors.black26,
                                  ])),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Description:', style: h2)),
                                  ),
                                  Text(missions['description'], style: h4)
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
