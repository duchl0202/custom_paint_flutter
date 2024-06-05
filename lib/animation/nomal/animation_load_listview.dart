import 'package:flutter/material.dart';

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _data =
      List.generate(20, (index) => 'Item $index'); // Tạo sẵn 20 item
  final Duration _initialDuration = Duration(milliseconds: 300);
  bool _isInitialAnimationDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _startInitialAnimation());
  }

  void _startInitialAnimation() async {
    for (int i = 0; i < _data.length; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      _listKey.currentState?.insertItem(i, duration: _initialDuration);
    }
    _isInitialAnimationDone = true;
  }

  void _addItem() {
    final index = _data.length;
    _data.add('Item $index');
    _listKey.currentState
        ?.insertItem(index, duration: const Duration(milliseconds: 500));
  }

  void _removeItem(int index) {
    final removedItem = _data.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(context, removedItem, animation),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildItem(
      BuildContext context, String item, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: Card(
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final index = _data.indexOf(item);
              _removeItem(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated List Example'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _isInitialAnimationDone ? _data.length : 0,
        itemBuilder: (context, index, animation) {
          return _buildItem(context, _data[index], animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
