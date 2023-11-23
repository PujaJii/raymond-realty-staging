import 'package:flutter/material.dart';



class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView with Header Row'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 100, // Adjust the header height as needed
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Header Row'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index == 0) {
                    // This is the header row
                    return HeaderRow();
                  } else {
                    // This is a list item
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  }
                },
                childCount: 50, // Replace with the actual number of items
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text('Title 1', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('Title 2', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('Title 3', textAlign: TextAlign.center),
        ),
        // Add more columns for additional titles
      ],
    );
  }
}
