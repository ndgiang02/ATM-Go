import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    required this.hint,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  }) : super(key: key);
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey();

  bool get isDropdownOpen => _overlayEntry != null;

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: size.width,
            left: offset.dx,
            top: offset.dy + size.height + 10,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children:
                        widget.items.map((item) {
                          return InkWell(
                            onTap: () {
                              widget.onChanged?.call(item.value);
                              _closeDropdown();
                            },
                            child: Container(
                              padding: widget.padding,
                              child: item.child,
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(_overlayEntry!);
    setState(() {});
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse:
          () => DropdownMenuItem<T>(
            value: null,
            child: Text(
              widget.hint,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _key,
        onTap: _toggleDropdown,
        child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: widget.padding,
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey.shade300,
              ),
            ),
          ),
          isEmpty: widget.value == null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: selectedItem.child),
              Icon(
                isDropdownOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
