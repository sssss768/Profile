export interface UserInfo {
  user_id: number;
  username: string;
  phone: string;
  avatar_url: string;
  campus_id: number;
  balance: number;
}

export interface UserInfoWithPassword extends UserInfo {
  password: string;
}

export interface MerchantInfo {
  merchant_id: number;
  shop_name: string;
  address: string;
  contact_phone: string;
  avg_rating: number;
}

export interface MerchantInfoWithPassword extends MerchantInfo {
  password: string;
}

export interface RiderInfo {
  rider_id: number;
  username: string;
  phone: string;
  status: number;
}

export interface RiderInfoWithPassword extends RiderInfo {
  password: string;
}

export type UserType = 'user' | 'merchant' | 'rider'; 