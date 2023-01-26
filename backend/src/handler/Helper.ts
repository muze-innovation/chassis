import { readFileSync } from 'fs'
import { BaseViewSpec } from '../spec/BaseViewSpec'

export class Helper {
  /**
   * readJsonFileInput
   */
  public static parseJsonToShelf(inputPath: string): BaseViewSpec[] {
    // read json file data need to validate
    const data = readFileSync(process.cwd() + inputPath)
    return JSON.parse(data.toString()) as BaseViewSpec[]
  }
}
