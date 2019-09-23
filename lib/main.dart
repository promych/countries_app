import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'app/app_manager.dart';
import 'ui/home.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(uri: 'https://countries.trevorblades.com/'),
        cache: InMemoryCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          home: CupertinoPageScaffold(
            child: Query(
              options: QueryOptions(
                  document:
                      'query GetCountries{ countries { name, emoji, native, currency, phone, languages { name } } }'),
              builder: (QueryResult result,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result.loading)
                  return Center(child: CupertinoActivityIndicator());
                if (result.data == null) return Center(child: Text('No data'));
                return ChangeNotifierProvider<AppManager>(
                  builder: (_) => AppManager.instance(result.data),
                  child: HomePage(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
