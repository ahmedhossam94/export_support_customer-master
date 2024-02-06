import 'package:flutter/widgets.dart';

//Type _getType<B>() => B;

class BaseProvider<B> extends InheritedWidget {
  final B bloc;

  BaseProvider({
    Key? key,
    required this.bloc,
    Widget? child,
  }) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(BaseProvider<B> oldWidget) {
    return oldWidget.bloc != bloc;
  }

  static B of<B>(BuildContext context) {
    // final type = _getType<Provider<B>>();
    // final Provider<B> provider = context.inheritFromWidgetOfExactType(type);

    // return provider.bloc;

    final BaseProvider<B>? provider =
        context.dependOnInheritedWidgetOfExactType<BaseProvider<B>>();
    return provider!.bloc;
  }
}

class BlocBaseProvider<B> extends StatefulWidget {
  final void Function(BuildContext context, B bloc) onDispose;
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;

  BlocBaseProvider({
    Key? key,
    required this.child,
    required this.builder,
    required this.onDispose,
  }) : super(key: key);

  @override
  _BlocBaseProviderState<B> createState() => _BlocBaseProviderState<B>();
}

class _BlocBaseProviderState<B> extends State<BlocBaseProvider<B>> {
  B? bloc;

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) {
      bloc = widget.builder(context, bloc!);
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose(context, bloc!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseProvider(
      bloc: bloc,
      child: widget.child,
    );
  }
}
