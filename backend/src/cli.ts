#!/usr/bin/env node

import Chassis from './handler/Chassis'
import yargs from 'yargs'
import { resolve } from 'path'
import * as fs from 'fs'

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
    let spec: string[] = []

    // If dir is not undefined
    if (argv.dir) {
      spec = fs.readdirSync(argv.dir).map(fileName => {
        return `${argv.dir}/${fileName}`
      })
    } else {
      // Split path file
      spec = argv.spec[0].split(',')
    }

    // Create new instance
    const chassis = new Chassis(spec.map(s => resolve(s)))
    // Validate spec
    const isValid = await chassis.validateSpec(argv.source)
    console.log(isValid)
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
    // Create new instance
    const chassis = new Chassis([resolve(argv.file)])
    // Generate schema
    const schema = await chassis.generateJsonSchemaBySymbol(argv.symbol)
    // Log schema
    console.log(JSON.stringify(schema, null, 2))
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
    // Create new instance
    const chassis = new Chassis([resolve(argv.file)])
    // Generate schema
    const schema = await chassis.generateJsonSchemaBySymbol(argv.symbol)

    const dir = argv.output
    // If output option is undefined
    if (!dir) {
      fs.writeFileSync(`./src/${argv.symbol}.json`, JSON.stringify(schema, null, 2))
    } else {
      // If directory not exist
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true })
      }
      fs.writeFileSync(`${dir}/${argv.symbol}.json`, JSON.stringify(schema, null, 2))
    }
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
    // Create new instance
    const chassis = new Chassis([resolve(argv.file)])
    // Generate all schema
    const schema = await chassis.generateJsonSchemaFile()

    const dir = argv.output
    // If output option is undefined
    if (!dir) {
      fs.writeFileSync(`./src/Schema.json`, JSON.stringify(schema, null, 2))
    } else {
      // If directory not exist
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true })
      }
      fs.writeFileSync(`${dir}/Schema.json`, JSON.stringify(schema, null, 2))
    }
  },
})

yargs.parse()
