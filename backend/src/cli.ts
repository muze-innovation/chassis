#!/usr/bin/env node

import Chassis from './handler/Chassis'
import yargs from 'yargs'
import { readFileSync } from 'fs'
import { resolve } from 'path'

yargs
  .command({
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
          demandOption: true,
        }),
    handler: async argv => {
      try {
        const spec: string[] = argv.spec[0].split(',')
        const chassis = new Chassis(spec.map(s => resolve(__dirname, s)))
        const isValid = await chassis.validateSpec(argv.source)
        console.log(isValid)
      } catch (err) {
        console.error(err)
      }
    },
  })
  .help()

yargs
  .command({
    command: 'generate',
    describe: 'Generate the output',
    builder: yargs =>
      yargs.options('spec', {
        alias: 's',
        type: 'string',
        demandOption: true,
        describe: 'Specification file path',
      }),
    handler: async argv => {
      // TODO: implement generate spec schema command
      const chassis = new Chassis([resolve(__dirname, argv.spec)])
    },
  })
  .help()

yargs.parse()
