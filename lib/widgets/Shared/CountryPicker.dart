// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:search_choices/search_choices.dart';

// Project imports:
import '../../config/country_config.dart';
import '../../controller/NewsAPiController.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({
    Key? key,
    required this.apiPathController,
    required this.trailing,
    required this.hint,
    required this.toLoad,
  }) : super(key: key);

  final NewsApiController apiPathController;
  final Widget trailing;
  final String hint;
  final bool toLoad;
  @override
  Widget build(BuildContext context) {
    return SearchChoices.single(
      icon: trailing,
      underline: Container(
        height: 0,
        width: 0,
      ),
      displayClearIcon: false,
      padding: 10,
      searchInputDecoration: InputDecoration(
        icon: const Icon(
          Icons.search,
          color: Colors.green,
          size: 24,
        ),
        alignLabelWithHint: true,
      ),
      items: countryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.normal, color: Colors.green),
          ),
        );
      }).toList(),
      value: apiPathController.country.value.toUpperCase(),
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.normal, color: Colors.green),
      hint: Text(
        hint,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.green),
      ),
      keyboardType: TextInputType.name,
      onChanged: (value) =>
          apiPathController.setCountry(selectedCountry: value, toLoad: toLoad),
      isExpanded: true,
      buildDropDownDialog: (
        Widget titleBar,
        Widget searchBar,
        Widget list,
        Widget closeButton,
        BuildContext dropDownContext,
      ) {
        return (AnimatedContainer(
          padding: MediaQuery.of(dropDownContext).viewInsets,
          duration: const Duration(milliseconds: 300),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  titleBar,
                  searchBar,
                  list,
                  closeButton,
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
