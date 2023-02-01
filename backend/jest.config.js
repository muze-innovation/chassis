module.exports = {
  testMatch: [
    "**/__tests__/**/*.test.ts"
  ],
  testPathIgnorePatterns: [
    "/node_modules/",
    "/dist/"
  ],
  moduleFileExtensions: [
    "ts",
    "tsx",
    "js",
    "json"
  ],
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/$1"
  },
  transform: {
    "^.+\\.tsx?$": "ts-jest"
  },
  testEnvironment: "node"
};
