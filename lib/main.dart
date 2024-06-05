import 'package:flutter/material.dart';
import 'package:flutter_custom_pain/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageViewExample(),
    );
  }
}

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<WidgetModel> _pages = [...widgets];
  WidgetType? _selectedType;
  Mode? _selectedMode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  void _filterPages() {
    setState(() {
      _pages = widgets.where((page) {
        if (_selectedType != null && page.type != _selectedType) {
          return false;
        }
        if (_selectedMode != null && page.mode != _selectedMode) {
          return false;
        }
        return true;
      }).toList();
      _tabController = TabController(length: _pages.length, vsync: this);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Flutter Interactive Examples'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _pages.map((page) {
            return Tab(text: page.title.split('Widget')[0]);
          }).toList(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Filter Options'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ...WidgetType.values.map((type) {
              return ExpansionTile(
                title: Text(type.toString().split('.').last),
                children: Mode.values.map((mode) {
                  return ListTile(
                    title: Text(mode.toString().split('.').last),
                    onTap: () {
                      setState(() {
                        _selectedType = type;
                        _selectedMode = mode;
                        _filterPages();
                        Navigator.pop(context); // Đóng Drawer sau khi chọn
                      });
                    },
                  );
                }).toList(),
              );
            }).toList(),
            ListTile(
              title: Text('Clear Filters'),
              onTap: () {
                setState(() {
                  _selectedType = null;
                  _selectedMode = null;
                  _filterPages();
                  Navigator.pop(context); // Đóng Drawer sau khi chọn
                });
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages.map((e) => e.widget).toList(),
      ),
    );
  }
}
