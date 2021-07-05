import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spacex_rockets/constants.dart';
import 'package:spacex_rockets/rocketdata.dart';

class Rocket extends StatefulWidget {
  static final HttpLink httpLink = HttpLink(
    'https://api.spacex.land/graphql/',
  );

  const Rocket({Key? key}) : super(key: key);

  @override
  _RocketState createState() => _RocketState();
}

class _RocketState extends State<Rocket> {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: Rocket.httpLink,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SpaceX Rockets',
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Query(
                options: QueryOptions(
                  document: gql(rockets),
                ),
                builder: (result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF5951c9))));
                  }

                  List rockets = result.data!['rockets'];

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: rockets.length,
                    itemBuilder: (context, index) {
                      final rocket = rockets[index];
                      return Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RocketData(id: rocket['id'])));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(rocketImages[index]),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.7),
                                        BlendMode.dstATop),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    rocket['name'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(Icons.visibility),
                                  )
                                ],
                              ),
                            ),
                          ),
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
