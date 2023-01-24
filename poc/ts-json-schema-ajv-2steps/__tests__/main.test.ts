import basicMockData from "./test-basic-field.json";
import nestedMockData from "./test-nested-field.json";
import { validateBasicSpec, validatePayload } from "../src/main";

// Test with miss names field.
test("validateBasic function with missing name fields", () => {
  const basic = validateBasicSpec(basicMockData);
  expect(basic).toBe(false);
});

// test("validatePayload function with preload type 'static' to be type 'remote'", () => {
//   const payload = validatePayload(nestedMockData);
//   expect(payload).toBe(false);
// });
