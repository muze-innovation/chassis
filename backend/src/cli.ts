#!/usr/bin/env node

import ChassisHelper from './handler/ChassisHelper'
import yargs from 'yargs'

yargs.command({
  command: 'validate',
  describe: 'Validate a JSON file',
  builder: yargs =>
    yargs
      .option('source', {
        alias: 'i',
        describe: 'The JSON file to validate',
        type: 'string',
        demandOption: true,
      })
      .option('spec', {
        alias: 's',
        describe: 'Array of specification files',
        type: 'array',
      })
      .option('dir', {
        alias: 'd',
        describe: 'Path of specification directory',
        type: 'string',
      })
      .check(argv => {
        if (!argv.spec && !argv.dir) {
          throw new Error('Either --spec or --dir must be specified.')
        }
        return true
      }),
  handler: async argv => {
    await ChassisHelper.validateSpec(argv.source, argv.spec, argv.dir)
  },
})

yargs.command({
  command: 'get-schema',
  describe: 'Get Specification schema',
  builder: yargs =>
    yargs
      .options('file', {
        alias: 'f',
        type: 'string',
        demandOption: true,
        describe: 'Specification file path',
      })
      .options('symbol', {
        alias: 's',
        type: 'string',
        demandOption: true,
        describe: 'Symbol',
      }),
  handler: async argv => {
    await ChassisHelper.generateJsonSchemaBySymbol(argv.file, argv.symbol)
  },
})

yargs.command({
  command: 'gen-schema',
  describe: 'Generate json schema by symbol',
  builder: yargs =>
    yargs
      .options('file', {
        alias: 'f',
        type: 'string',
        demandOption: true,
        describe: 'Specification file path',
      })
      .options('symbol', {
        alias: 's',
        type: 'string',
        demandOption: true,
        describe: 'Symbol',
      })
      .options('output', {
        alias: 'o',
        type: 'string',
        describe: 'Output directory',
      }),
  handler: async argv => {
    await ChassisHelper.generateJsonSchemaFile(argv.file, argv.symbol, argv.output)
  },
})

yargs.command({
  command: 'gen-schema-all',
  describe: 'Generate json schema',
  builder: yargs =>
    yargs
      .options('file', {
        alias: 'f',
        type: 'string',
        demandOption: true,
        describe: 'Specification file path',
      })
      .options('output', {
        alias: 'o',
        type: 'string',
        describe: 'Output directory',
      }),
  handler: async argv => {
    await ChassisHelper.generateJsonSchemaFile(argv.file, '', argv.output, true)
  },
})

yargs.parse()
