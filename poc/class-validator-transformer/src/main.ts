import { plainToClass } from "class-transformer";
import data from "./source/json.json";
import Banner from "./spec/Banner";

for (let i = 0; i < data.length; i++) {
  const myData = plainToClass(Banner, data[i]);
  //   console.log(myData);
  myData.onValidate();
}
