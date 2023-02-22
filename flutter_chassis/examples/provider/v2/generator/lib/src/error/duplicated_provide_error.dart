import 'package:analyzer/dart/element/element.dart';

import '../data/pair.dart';

class DuplicatedResolverError extends AssertionError {
  String? resolver = "";
  Pair<ClassElement, MethodElement>? pairOfClassAndMethod = null;

  DuplicatedResolverError({this.resolver, this.pairOfClassAndMethod})
      : super(
            "@Resolves(resolvedWith: '${resolver}') has duplicated on ${pairOfClassAndMethod?.second.toString()}(...) (${pairOfClassAndMethod?.first.name})");
}
