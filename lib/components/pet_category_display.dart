import 'package:petcom/components/pet_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loadmore/loadmore.dart';

import '../configuration.dart';

class PetCategoryDisplay extends StatelessWidget {
  const PetCategoryDisplay({Key? key}) : super(key: key);

  //TODO: GET Request to /api/breeder
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Container(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: breeder.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: ScaleAnimation(
                    child: PetCard(
                      id: breeder[index]['id'],
                      title: breeder[index]['title'],
                      score: breeder[index]['score'],
                      type: breeder[index]['type'],
                      description: breeder[index]['description'],
                      createTime: breeder[index]['create_time'],
                      address: breeder[index]['address'],
                      city: breeder[index]['city'],
                      state: breeder[index]['state'],
                      contact: breeder[index]['contact'],
                      website: breeder[index]['website'],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
