import 'package:flutter/material.dart';

import 'package:ecos/features/profile/profile.dart';

class ClickListContainer extends StatelessWidget {
  const ClickListContainer({
    super.key,
    required this.items,
  });

  final List<ClickItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          indent: 16.0,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: items[index].onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    items[index].name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
