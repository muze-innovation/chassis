import { BaseShelf } from "./BaseShelf";

export interface ShelfContent extends BaseShelf {
  viewType: "ShelfContent";
  payload: ShelfContentPayloadStatic;
}

//// ViewType ShelfContent and type static.
/**
 *
 *
 *
 * @additionalProperties false
 */
export interface ShelfContentPayloadStatic {
  type: "static";
  data: ShelfContentData;
}

export interface ShelfContentData {
  item: {
    title: string;
    asset: string;
  }[];
}

// /**
//  *
//  *
//  *
//  * @additionalProperties false
//  */
