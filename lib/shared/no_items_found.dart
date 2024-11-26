import 'package:flutter/material.dart';
import 'package:revivals/shared/styled_text.dart';

class NoItemsFound extends StatelessWidget {
  const NoItemsFound({super.key});
 

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: width * 0.5),
        Center(child: Image.asset('assets/img/icons/no_search_result_icon.webp', height: width * 0.1)),
        SizedBox(height: width * 0.03),
        const Center(child: StyledHeading('No Results Found')),
        SizedBox(height: width * 0.03),
        const Center(child: StyledHeading('Sorry, no items matched your criteria.', weight: FontWeight.normal)),
        const Center(child: StyledHeading('Please reset your filter for more results', weight: FontWeight.normal)),
        // ElevatedButton(
        //   onPressed: () {
        //                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => (FiltersPage(setFilter: setFilter, setValues: setValues))));

        //   }  , 
        //   child: const Text('RESET')
        // )
      ],
    );
  }
}