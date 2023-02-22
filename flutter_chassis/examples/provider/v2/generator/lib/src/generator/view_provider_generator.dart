import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dart_style/dart_style.dart';
import 'package:chassis_annotation/annotation.dart';

import '../util/utils.dart';

class ViewProviderGenerator extends GeneratorForAnnotation<ViewProvider> {
  final _parentClassType = 'ViewProviderBase';
  final _viewResolverType = 'ViewResolver';

  final _resolverRouteTableFieldName = '_resolverRouteTable';
  final _streamType = 'Stream<dynamic>';

  List<ClassElement> _viewResolvers = List.empty(growable: true);
  Iterable<String> get _viewResolverNames =>
      _viewResolvers.map((resolver) => resolver.name);

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final resolvers = _getViewResolvers(annotation);
    if (resolvers != null) {
      _viewResolvers
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
    return [_generateRouteTableMethod(), _generateGetViewMethod()];
  }

  Field _generateResolversField() {
    final fieldName = _resolverRouteTableFieldName;
    final fieldType = 'Map<String, $_viewResolverType>';

    return Field((builder) => builder
      ..modifier = FieldModifier.final$
      ..type = refer(fieldType)
      ..name = fieldName);
  }

  Method _generateGetViewMethod() {
    final methodName = 'getView';
    final methodAnnotation = 'override';
    final paramStreamType = _streamType;
    final paramStreamName = 'stream';
    final paramItemType = 'Item';
    final paramItemName = 'item';

    return Method.returnsVoid((builder) => builder
      ..annotations.add(refer(methodAnnotation))
      ..name = methodName
      ..requiredParameters.addAll([
        Parameter((builder) => builder
          ..type = refer(paramStreamType)
          ..name = paramStreamName),
        Parameter((builder) => builder
          ..type = refer(paramItemType)
          ..name = paramItemName)
      ])
      ..body = Code(
          '$_resolverRouteTableFieldName[$paramItemName.viewType]?.getView($paramStreamName, $paramItemName);'));
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
    final resolverNames = _viewResolverNames;
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

  ConstantReader? _getViewResolverAnnotation(ClassElement clss) =>
      _getAnnotation(clss, ViewResolver);

  Iterable<ClassElement>? _getViewResolvers(ConstantReader annotation) =>
      annotation
          .peek('resolvers')
          ?.listValue
          .map((object) => object.toTypeValue()!.element as ClassElement)
          .where((clss) => _getViewResolverAnnotation(clss) != null);
}
