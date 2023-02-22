import 'package:build/build.dart';
import 'package:chassis_generator/src/generator/data_provider_generator.dart';
import 'package:chassis_generator/src/generator/data_resolver_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builder for DataProviders
Builder chassisBuilder(BuilderOptions options) => PartBuilder(
    [DataProviderGenerator(), DataResolverGenerator()], '.chassis.dart');
