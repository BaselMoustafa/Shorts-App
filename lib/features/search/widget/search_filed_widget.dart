import 'package:flutter/material.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/widgets/custom_text_form_filed.dart';
import '../search_persons_cubit/search_persons_cubit.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({super.key});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController=TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: ()=>NavigatorManager.pop(context: context), 
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: CustomTextFormField(
                textFormFieldProperties:TextFormFieldProperties(
                  labelText: "Search For ",
                  controller:_searchController,
                  onChanged: (value) {
                    SearchPersonsCubit.get(context).searchPersons(value);
                  },
                )
              ),
            )
          )
        ],
      ),
    );
  }
}