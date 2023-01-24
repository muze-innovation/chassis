import Ajv from "ajv";
import JsonSchemaDiff from "json-schema-diff";

import data from "../../data/json-output.json";
import { generator } from "./TJSconfig";

// Declare AJV that used to validate between schema and data.
const ajv = new Ajv();

// Validate Basic Field (Not including nested field)
function validateBasicSpec(jsonData: {}): boolean {
  const basicSpec = generator.getSchemaForSymbol("Spec");
  const basicValidate = ajv.compile(basicSpec);
  const basicValid = basicValidate(jsonData);

  if (!basicValid) console.log(basicValidate.errors);
  return basicValid;
}

// Validate by viewType with payload type "static" or "remote".
function validatePayload(jsonData: any) {
  const allShelfFromData = jsonData.items;

  // Loop to validate each payload in shelf.
  for (const shelfData of allShelfFromData) {
    const viewType = shelfData.viewType;

    try {
      if (typeof viewType !== "string" || !viewType) {
        console.log(`viewType of ${shelfData.id} is invalid`);
      } else {
        const viewTypeSchema = generator.getSchemaForSymbol(viewType);
        const validate = ajv.compile(viewTypeSchema);
        const valid = validate(shelfData);

        if (!valid) {
          console.log(`${JSON.stringify(validate.errors, null, 2)}
      Error in Payload '${shelfData.id}' id and '${viewType}' viewType`);
        }
      }
    } catch (e) {
      console.log(`${viewType} viewType is invalid`);
    }
  }
}

// Validate resolver output that matches resolverSpec or not.
async function validateResolverSpec(jsonData: any) {
  const allShelfFromData = jsonData.items;

  // Loop to validate each payload in shelf.
  for (const shelfData of allShelfFromData) {
    const viewType = shelfData.viewType;
    const resolvedWith = shelfData.payload?.resolvedWith ?? "";

    if (resolvedWith) {
      //// This Line can generate All definitions that used in this function.
      // const test = generator.ReffedDefinitions;
      // console.log(test);

      const resolverSchema = generator.getSchemaForSymbol(resolvedWith);
      const payloadSchema = generator.getSchemaForSymbol(viewType + "Data");

      const result = await JsonSchemaDiff.diffSchemas({
        sourceSchema: resolverSchema as any,
        destinationSchema: payloadSchema as any,
      });

      if (!result.removalsFound && !result.additionsFound) {
        console.log("Your data is ready");
      } else {
        console.log("Your data from resolver method is incomplete");
      }
    }
  }
}

if (validateBasicSpec(data)) {
  validatePayload(data);
  validateResolverSpec(data);
}

export { validateBasicSpec, validatePayload };
