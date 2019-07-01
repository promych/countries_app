import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar({Key key, this.controller, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: CupertinoColors.inactiveGray,
              ),
              Expanded(
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  cursorColor: CupertinoColors.inactiveGray,
                ),
              ),
              GestureDetector(
                onTap: controller.clear,
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: CupertinoColors.inactiveGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
