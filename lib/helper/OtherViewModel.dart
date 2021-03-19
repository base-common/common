import 'PublishStreamViewModel.dart';
import 'StreamViewModel.dart';

class BooleanViewModel with StreamViewModel<bool> {}

class StringViewModel with StreamViewModel<String> {}

class NumberViewModel with StreamViewModel<num> {}

class DoubleViewModel with StreamViewModel<double> {}

class IntViewModel with StreamViewModel<int> {}

class ListViewModel with StreamViewModel<List> {}

class DynamicViewModel with StreamViewModel<dynamic> {}

class ModelViewModel<T> with StreamViewModel<T>{}

class PublishDynamicViewModel with PublishStreamViewModel<dynamic> {}

class LoadingViewModel with StreamViewModel<bool> {
  LoadingViewModel({bool defaultValue = true}) {
    inputStream.add(defaultValue);
  }
}
