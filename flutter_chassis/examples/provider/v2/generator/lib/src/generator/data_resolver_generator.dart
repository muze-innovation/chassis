import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dart_style/dart_style.dart';
import 'package:chassis_annotation/annotation.dart';

import '../util/utils.dart';

class DataResolverGenerator extends GeneratorForAnnotation<DataResolver> {
  final _parentClassType = 'DataResolver';
  final _routeTableMethodName = '_getRouteTableFor';

  // List<MethodElement> _overriddenMethods = List.empty(growable: true);

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      final baseClass;
      try {
        baseClass = element.allSupertypes.firstWhere((element) =>
            element.getDisplayString(withNullability: false) ==
            'ResolverPipeline');
        if (baseClass != null) {
          final methods = element.methods
              .where((method) => method.hasOverride)
              .map((method) => baseClass.getMethod(method.name));
          if (methods.isNotEmpty) {
            final overriddenMethods = List<MethodElement>.empty(growable: true);
            for (var method in methods) {
              if (method != null) {
                overriddenMethods.add(method);
              }
            }
            return _build(element, overriddenMethods);
          } else {
            log.severe(
                '[ERROR] ${element.name} has not overridden any methods in ${baseClass.getDisplayString(withNullability: false)}.');
          }
        }
      } catch (Exception) {
        log.severe(
            '[ERROR] ${element.name} did not inherit DataResolverEntry.');
      }
    }
  }

  String _build(ClassElement element, List<MethodElement> methods) {
    final method = _generateRouteTableMethod(element.name, methods);
    final emitter = DartEmitter(useNullSafetySyntax: true);
    final buffer = StringBuffer()..writeln('${method.accept(emitter)}');
    return DartFormatter().format(buffer.toString());
  }

  Method _generateRouteTableMethod(
      String className, List<MethodElement> methods) {
    final methodName = '$_routeTableMethodName${className}';
    final returnType = 'Map<String, $_parentClassType>';

    final resolvers = methods.map((method) =>
        _getResolvesAnnotation(method)!.peek('resolvedWith')!.stringValue);

    return Method((builder) {
      final paramType = 'DataResolver';
      final paramName = 'dataResolver';

      builder
        ..returns = refer(returnType)
        ..name = methodName
        ..requiredParameters.add(Parameter((builder) => builder
          ..type = refer(paramType)
          ..name = paramName))
        ..lambda = true
        ..body = Code(
            '{${resolvers.map((resolver) => '\'$resolver\': $paramName').join(', ')}};');
    });
  }

  ConstantReader? _getAnnotation(Element element, Type type) =>
      GeneratorUtils.getAnnotation(element, type);

  ConstantReader? _getResolvesAnnotation(MethodElement method) =>
      _getAnnotation(method, Resolves);
}
