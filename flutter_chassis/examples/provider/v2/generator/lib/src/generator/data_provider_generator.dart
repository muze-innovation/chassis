import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dart_style/dart_style.dart';
import 'package:chassis_annotation/annotation.dart';

import '../util/utils.dart';

class DataProviderGenerator extends GeneratorForAnnotation<DataProvider> {
  final _parentClassType = 'DataProviderBase';
  final _dataResolverType = 'DataResolver';

  final _resolverRouteTableFieldName = '_resolverRouteTable';
  final _streamControllerType = 'StreamController<Map<String, dynamic>>';

  List<ClassElement> _dataResolvers = List.empty(growable: true);
  Iterable<String> get _dataResolverNames =>
      _dataResolvers.map((resolver) => resolver.name);

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final resolvers = _getDataResolvers(annotation);
    if (resolvers != null) {
      _dataResolvers
          .addAll(resolvers.toSet().toList()); // remove duplicated resolver
    }
    return _build(element as ClassElement);
  }

  String _build(ClassElement element) {
    final parentClassName = _parentClassType;
    final className = '_${element.name}';
    final classBuilder = Class((builder) => builder
      ..abstract = true
      ..name = className
      ..extend = refer(parentClassName)
      ..fields.addAll(_classFields)
      ..methods.addAll(_classMethods)
      ..constructors.addAll(_classConstructors));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final buffer = StringBuffer()..writeln('${classBuilder.accept(emitter)}');
    return DartFormatter().format(buffer.toString());
  }

  Iterable<Field> get _classFields {
    return [_generateResolversField()];
  }

  Iterable<Constructor> get _classConstructors {
    return [_generateConstructor()];
  }

  Iterable<Method> get _classMethods {
    return [_generateRouteTableMethod(), _generateGetDataMethod()];
  }

  Field _generateResolversField() {
    final fieldName = _resolverRouteTableFieldName;
    final fieldType = 'Map<String, $_dataResolverType>';

    return Field((builder) => builder
      ..modifier = FieldModifier.final$
      ..type = refer(fieldType)
      ..name = fieldName);
  }

  Method _generateGetDataMethod() {
    final methodName = 'getData';
    final methodAnnotation = 'override';
    final paramStreamControllerType = _streamControllerType;
    final paramStreamControllerName = 'controller';
    final paramRequestType = 'Request';
    final paramRequestName = 'request';

    return Method.returnsVoid((builder) => builder
      ..annotations.add(refer(methodAnnotation))
      ..name = methodName
      ..requiredParameters.addAll([
        Parameter((builder) => builder
          ..type = refer(paramStreamControllerType)
          ..name = paramStreamControllerName),
        Parameter((builder) => builder
          ..type = refer(paramRequestType)
          ..name = paramRequestName)
      ])
      ..body = Code(
          '$_resolverRouteTableFieldName[$paramRequestName.resolvedWith]?.getData($paramStreamControllerName, $paramRequestName);'));
  }

  Method _generateRouteTableMethod() {
    final methodName = 'routeTable';
    final returnType = 'Map<String, $_parentClassType>';

    return Method((builder) {
      builder
        ..annotations.add(refer('override'))
        ..type = MethodType.getter
        ..returns = refer(returnType)
        ..name = methodName
        ..lambda = true
        ..body = Code(
            '$_resolverRouteTableFieldName.map((key, value) => MapEntry(key, this))');
    });
  }

  Constructor _generateConstructor() {
    final resolverNames = _dataResolverNames;
    final params =
        resolverNames.map((resolver) => Parameter((builder) => builder
          ..named = true
          ..required = true
          ..type = refer('$resolver')
          ..name = 'm$resolver'));

    return Constructor((builder) {
      final codeBuffer = StringBuffer()
        ..writeln('$_resolverRouteTableFieldName = {')
        ..writeln(
            resolverNames.map((name) => '...m$name.routeTable').join(', '))
        ..writeln('}');

      builder
        ..optionalParameters.addAll(params)
        ..initializers.add(Code(codeBuffer.toString()));
    });
  }

  ConstantReader? _getAnnotation(Element element, Type type) =>
      GeneratorUtils.getAnnotation(element, type);

  ConstantReader? _getDataResolverAnnotation(ClassElement clss) =>
      _getAnnotation(clss, DataResolver);

  Iterable<ClassElement>? _getDataResolvers(ConstantReader annotation) =>
      annotation
          .peek('resolvers')
          ?.listValue
          .map((object) => object.toTypeValue()!.element as ClassElement)
          .where((clss) => _getDataResolverAnnotation(clss) != null);
}
