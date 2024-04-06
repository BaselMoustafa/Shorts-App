import 'package:flutter/material.dart';

import '../../../dependancies/persons/domain/models/person.dart';
import 'person_search_item_widget.dart';

class SearchedPersonsListView extends StatelessWidget {
  const SearchedPersonsListView({super.key,required this.persons});
  final List<Person>persons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: persons.length,
      itemBuilder: (context,index)=>PersonSearchItemWidget(
        person: persons[index],
      ), 
      separatorBuilder: (context,index)=>const SizedBox(height: 10,), 
      
    );
  }
}
