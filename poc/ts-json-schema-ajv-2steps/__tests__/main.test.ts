import basicMockData from "./test-basic-field.json";
import nestedMockData from "./test-nested-field.json";
import { validateBasic, validatePayload } from "../src/main";

test("validateBasic function with missing name fields", () => {
  const basic = validateBasic(basicMockData);
  expect(basic).toBe(false);
});

test("validatePayload function with preload type 'static' to be type 'remote'", () => {
  const payload = validatePayload(nestedMockData);
  expect(payload).toBe(false);
});
