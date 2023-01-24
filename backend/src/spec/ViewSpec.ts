import { BaseShelf, BaseShelfAttribute, HeightPolicy, ViewType } from "./BaseShelf";

export interface Banner extends BaseShelf {
  id: string;
  viewType: ViewType;
  attributes: BannerAttributes;
  parameters?: BannerParameters;
  payload?: BannerPayload;
}

interface BannerAttributes extends BaseShelfAttribute {
  heightPolicy: HeightPolicy;
  heightValue: string;
}

interface BannerParameters {
  title: string;
}

interface BannerPayload {
  asset: string;
  placeholder: string;
}

export interface QuickAccess extends BaseShelf {
  id: string;
  viewType: ViewType;
  attributes: QuickAccessAttributes;
  parameters?: QuickAccessParameters;
  payload?: QuickAccessPayload;
}

interface QuickAccessAttributes extends BaseShelfAttribute {
  heightPolicy: HeightPolicy;
  heightValue: string;
}

interface QuickAccessParameters {
  title: string;
}

interface QuickAccessPayload {
  item: QuickAccessItem[];
}

interface QuickAccessItem {
  title: string;
  asset: string;
}

export interface ShelfContent extends BaseShelf {
  id: string;
  viewType: ViewType;
  attributes: ShelfContentAttributes;
  parameters?: ShelfContentParameters;
  payload?: ShelfContentPayload;
}

interface ShelfContentAttributes extends BaseShelfAttribute {
  heightPolicy: HeightPolicy;
  heightValue: string;
}

interface ShelfContentParameters {
  title: string;
}

interface ShelfContentPayload {
  item: ShelfContentItem[];
}

interface ShelfContentItem {
  title: string;
  asset: string;
}
