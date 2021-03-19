# common

api_provider: setup dio singleton

base_container: setup bottom navigation

navigator_manager: setup navigation

#Auth

sử dụng bloc

## Getting Started

 Dự án sử dụng package common với CustomNavigatorTabBar sử dụng ChangeNotifierProvider với ValueNotifier<int> để get và set index

### Để set index:
```
CustomNavigatorTabBar.of(context).setCurrentIndex = widget.index;
```
### Để get index:
```
Consumer<ValueNotifier<int>>(
    builder: (BuildContext context, value, Widget child) {
    return Widget;
}
```
