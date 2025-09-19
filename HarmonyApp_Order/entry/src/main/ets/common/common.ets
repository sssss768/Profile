import { MerchantInfo, RiderInfo, UserInfo, UserType } from "./UserInfo";

export interface ImageInfo {
  id: number;
  user_id: string;
  img: string;
  number: string;
  color: string;
  probability: string;
  time: string;
}

export interface NavParam {
  userType: UserType;
  userInfo: UserInfo | MerchantInfo | RiderInfo;
}