import { BaseShelf, BaseShelfAttribute } from "./BaseShelf";

export class Banner extends BaseShelf {
  id!: string;
  viewType!: "Banner";
  attributes!: BaseShelfAttribute;
}
