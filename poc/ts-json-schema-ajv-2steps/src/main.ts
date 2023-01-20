import Ajv from "ajv";
import data from "../../data/json-output.json";

import { generator } from "./TJSconfig";

// Declare AJV that used to validate between schema and data.
const ajv = new Ajv();

// Validate Basic Field (Not nested field)
function validateBasic(): boolean {
  const basicSpec = generator.getSchemaForSymbol("Spec");
  const basicValidate = ajv.compile(basicSpec);
  const basicValid = basicValidate(data);

  if (!basicValid) console.log(basicValidate.errors);
  return basicValid;
}

// Validate by viewType with payload type "static" or "remote".
// If it's remote, then check that method and if it's static, then will check data type instead.
function validatePayload(): void {
  const allShelfFromData = data.items;

  for (const shelfData of allShelfFromData) {
    const viewType = shelfData.viewType;

    if (typeof viewType !== "string" || !viewType) {
      console.log(`viewType of ${shelfData.id} is invalid`);
    } else {
      const viewTypeSchema = generator.getSchemaForSymbol(viewType);
      const payloadSchema = viewTypeSchema;
      const validate = ajv.compile(payloadSchema);
      const valid = validate(shelfData);

      if (!valid)
        console.log(`${JSON.stringify(validate.errors, null, 2)}
      Error ${shelfData.id} from ${viewType}`);
    }
  }
}

if (validateBasic()) validatePayload();
