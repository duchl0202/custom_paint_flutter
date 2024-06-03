import 'package:flutter/material.dart';

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _data = List.generate(20, (index) => 'Item $index');
  final Duration _initialDuration = Duration(milliseconds: 300);
  bool _isInitialAnimationDone = false;

  OverlayEntry? _overlayEntry;
  Offset _startPosition = Offset.zero;
  Offset _endPosition = Offset.zero;

  final GlobalKey _cartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startInitialAnimation());
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
    _listKey.currentState?.insertItem(index, duration: const Duration(milliseconds: 500));
  }

  void _removeItem(int index) {
    final removedItem = _data.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(context, removedItem, animation),
      duration: const Duration(milliseconds: 500),
    );
  }

  void _runAddToCartAnimation(GlobalKey itemKey) {
    final renderBox = itemKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      _startPosition = renderBox.localToGlobal(Offset.zero);
      final cartIconBox = _cartKey.currentContext?.findRenderObject() as RenderBox?;
      if (cartIconBox != null) {
        _endPosition = cartIconBox.localToGlobal(Offset.zero);
        _createOverlayEntry();
        _overlayEntry?.markNeedsBuild();
      }
    }
  }

  void _createOverlayEntry() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return AddToCartAnimation(
          startPosition: _startPosition,
          endPosition: _endPosition,
          onEnd: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        );
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    final itemKey = GlobalKey();
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: Card(
        child: ListTile(
          key: itemKey,
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              _runAddToCartAnimation(itemKey);
              Future.delayed(Duration(milliseconds: 500), _addItem);
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
        actions: [
          Icon(Icons.shopping_cart, key: _cartKey),
          SizedBox(width: 16),
        ],
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

class AddToCartAnimation extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final VoidCallback onEnd;

  const AddToCartAnimation({
    required this.startPosition,
    required this.endPosition,
    required this.onEnd,
  });

  @override
  _AddToCartAnimationState createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onEnd();
        }
      });

    _animation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: child!,
        );
      },
      child: Icon(Icons.shopping_cart, color: Colors.orange, size: 30),
    );
  }
}
