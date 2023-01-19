import { BaseShelf, BaseShelfAttribute } from "./BaseShelf";

export class QuickAccess extends BaseShelf {
  id!: string;
  viewType!: "QuickAccess";
  attributes!: BaseShelfAttribute;
}
