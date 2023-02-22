import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

class GeneratorUtils {
  static ConstantReader? getAnnotation(Element element, Type type) {
    final annotation = TypeChecker.fromRuntime(type)
        .firstAnnotationOf(element, throwOnUnresolved: false);
    if (annotation != null) {
      return ConstantReader(annotation);
    }
    return null;
  }
}
