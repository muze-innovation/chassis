import { BaseShelf } from "./BaseShelf";

type ViewSpec = Banner | QuickAccess;

export interface Banner extends BaseShelf {
  id: string;
  viewType: "Banner";
  parameters?: { title: string };
  payload?: {
    asset: string;
    placeholder: string;
  };
}

export interface QuickAccess extends BaseShelf {
  id: string;
  viewType: "QuickAccess";
  parameters?: {
    title: string;
  };
  payload?: {
    item: QuickAccessItem[];
  };
}

interface QuickAccessItem {
  title: string;
  asset: string;
}

export interface ShelfContent extends BaseShelf {
  id: string;
  viewType: "ShelfContent";
  parameters?: {
    title: string;
  };
  payload?: {
    item: ShelfContentItem[];
  };
}

interface ShelfContentItem {
  title: string;
  asset: string;
}
