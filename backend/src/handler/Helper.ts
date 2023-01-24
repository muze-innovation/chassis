import { readFileSync } from "fs";
import { BaseShelf } from "../spec/BaseShelf";

export class Helper {
  /**
   * readJsonFileInput
   */
  public static parseJsonToShelf(inputPath: string): BaseShelf[] {
    // read json file data need to validate
    const data = readFileSync(process.cwd() + inputPath);
    return JSON.parse(data.toString()) as BaseShelf[];
  }
}
