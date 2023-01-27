#!/usr/bin/env node

import Chassis from './handler/Chassis'
import { resolve } from 'path'
import yargs from 'yargs'

yargs.command({
  command: 'validate',
  describe: 'Validate a JSON file',
  builder: yargs =>
    yargs
      .option('source', {
        describe: 'The JSON file to validate',
        type: 'string',
        demandOption: true,
      })
      .option('viewSpec', {
        describe: 'The view specification file',
        type: 'string',
        demandOption: true,
      })
      .option('resolverSpec', {
        describe: 'The resolver specification file',
        type: 'string',
        demandOption: true,
      }),
  handler: argv => {
    console.log(`Validating source: ${argv.source}`)
    console.log(`View Spec: ${argv.viewSpec}`)
    console.log(`Resolver Spec: ${argv.resolverSpec}`)

    const chassis = new Chassis([resolve(argv.viewSpec), resolve(argv.resolverSpec)])
    chassis.validateSpec(argv.source)
  },
})

yargs.parse()
