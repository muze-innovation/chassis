/**
 *
 *
 *
 * @additionalProperties false
 */
export interface Spec {
  version: string;
  name: string;
  items: BaseShelf[];
}
/**
 *
 *
 *
 * @additionalProperties false
 */
export interface BaseShelf {
  id: string;
  attributes: BaseShelfAttribute;
  parameters?: BaseShelfParameter;
  viewType: string;
  payload?: BaseShelfPayload;
}

export interface BaseShelfAttribute {
  heightPolicy: "fixed" | "ratio" | "wrap";
  heightValue: string;
}
export interface BaseShelfParameter {
  title: string;
}

export interface BaseShelfPayload {
  type: "static" | "remote";
  resolvedWith?: string;
  input?: any;
  data?: any;
}
