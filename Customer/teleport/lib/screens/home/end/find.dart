import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:teleport/models/user.dart';
import 'package:teleport/screens/home/end/find_item.dart';
import 'package:teleport/screens/home/end/item_view.dart';
import 'package:teleport/services/database.dart';
import 'package:teleport/shared/constants.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Usr>(context);
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: textInputDecoration.copyWith(
              hintText: 'Find what you need...',
              prefixIcon: IconButton(
                onPressed: (){},
                color: Colors.black,
                icon: Icon(Icons.search),
                iconSize: 25.0,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
              contentPadding: EdgeInsets.only(left: 25.0),
            ),
          ),
          suggestionsCallback: (searchKey) async {
            return DatabaseService(uid: usr.uid).getSuggestion(searchKey);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(suggestion.title ?? ''),
              subtitle: Text(suggestion.subtitle ?? ''),
            );
          },
          onSuggestionSelected: (suggestion) {
            if(suggestion.type=='item'){
              print('let\'s start');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      // builder: (context) => ItemView(
                      //     item: suggestion.item,
                      // ),
                      builder: (context) => FindItem(
                        item: suggestion.item,
                        shop: UsrData(
                          uid: suggestion.item.shopUID,
                          businessName: suggestion.item.shop,
                          name: suggestion.item.shop,
                        ),
                        itemsFuture: DatabaseService(uid: suggestion.item.shopUID).getItems(),
                      )
                  )
              );
            }
            else {
              print("YP");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindItem(
                      shop: suggestion.shop,
                      itemsFuture: DatabaseService(uid: suggestion.shop.uid).getItems(),
                    )
                  )
              );
            }
          },
        ),
      ),
    ]);
  }
}
