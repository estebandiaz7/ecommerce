export interface User {
  id: string
  email: string
  full_name: string
  created_at: string
  updated_at: string
  role: 'customer' | 'admin' | 'seller'
  profile?: UserProfile
  addresses?: Address[]
  payment_methods?: PaymentMethod[]
}

export interface UserProfile {
  id: string
  user_id: string
  avatar_url?: string
  phone_number?: string
  preferences: {
    language: string
    currency: string
    notifications: {
      email: boolean
      sms: boolean
    }
  }
  created_at: string
  updated_at: string
}

export interface Address {
  id: string
  user_id: string
  type: 'shipping' | 'billing'
  street: string
  city: string
  state: string
  country: string
  postal_code: string
  is_default: boolean
  created_at: string
  updated_at: string
}

export interface PaymentMethod {
  id: string
  user_id: string
  type: 'credit_card' | 'debit_card' | 'paypal' | 'bank_transfer'
  provider: string
  last_four: string
  expiry_date?: string
  is_default: boolean
  created_at: string
  updated_at: string
}

export interface Product {
  id: string
  seller_id: string
  name: string
  description: string
  price: number
  compare_at_price?: number
  cost_price: number
  sku: string
  barcode?: string
  weight?: number
  weight_unit: 'kg' | 'g' | 'lb' | 'oz'
  status: 'draft' | 'active' | 'archived'
  inventory_quantity: number
  allow_backorder: boolean
  categories: Category[]
  images: ProductImage[]
  variants?: ProductVariant[]
  attributes?: ProductAttribute[]
  created_at: string
  updated_at: string
}

export interface ProductImage {
  id: string
  product_id: string
  url: string
  alt_text?: string
  position: number
  created_at: string
  updated_at: string
}

export interface ProductVariant {
  id: string
  product_id: string
  sku: string
  price: number
  compare_at_price?: number
  inventory_quantity: number
  attributes: {
    [key: string]: string
  }
  created_at: string
  updated_at: string
}

export interface ProductAttribute {
  id: string
  product_id: string
  name: string
  value: string
  created_at: string
  updated_at: string
}

export interface Category {
  id: string
  name: string
  slug: string
  description?: string
  parent_id?: string
  image_url?: string
  position: number
  created_at: string
  updated_at: string
}

export interface Order {
  id: string
  user_id: string
  status:
    | 'pending'
    | 'processing'
    | 'shipped'
    | 'delivered'
    | 'cancelled'
    | 'refunded'
  total_amount: number
  subtotal: number
  tax_amount: number
  shipping_amount: number
  discount_amount: number
  currency: string
  shipping_address: Address
  billing_address: Address
  payment_method: PaymentMethod
  items: OrderItem[]
  created_at: string
  updated_at: string
}

export interface OrderItem {
  id: string
  order_id: string
  product_id: string
  variant_id?: string
  quantity: number
  price: number
  total: number
  created_at: string
  updated_at: string
}

export interface Cart {
  id: string
  user_id: string
  items: CartItem[]
  created_at: string
  updated_at: string
}

export interface CartItem {
  id: string
  cart_id: string
  product_id: string
  variant_id?: string
  quantity: number
  created_at: string
  updated_at: string
}

export interface Review {
  id: string
  user_id: string
  product_id: string
  rating: number
  title?: string
  content: string
  status: 'pending' | 'approved' | 'rejected'
  created_at: string
  updated_at: string
}

export interface Wishlist {
  id: string
  user_id: string
  items: WishlistItem[]
  created_at: string
  updated_at: string
}

export interface WishlistItem {
  id: string
  wishlist_id: string
  product_id: string
  created_at: string
  updated_at: string
}

export interface Promotion {
  id: string
  code: string
  type: 'percentage' | 'fixed_amount' | 'free_shipping'
  value: number
  min_purchase_amount?: number
  start_date: string
  end_date: string
  max_uses?: number
  used_count: number
  status: 'active' | 'inactive' | 'expired'
  created_at: string
  updated_at: string
}

export interface ShippingMethod {
  id: string
  name: string
  description?: string
  price: number
  min_delivery_days: number
  max_delivery_days: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface Notification {
  id: string
  user_id: string
  type: 'order' | 'promotion' | 'system' | 'review'
  title: string
  message: string
  is_read: boolean
  created_at: string
  updated_at: string
}
