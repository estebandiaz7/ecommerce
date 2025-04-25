-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE cart_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists ENABLE ROW LEVEL SECURITY;
ALTER TABLE wishlist_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Create function to check if user is authenticated
CREATE OR REPLACE FUNCTION is_authenticated()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN auth.uid() IS NOT NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if user is admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users
    WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if user is seller
CREATE OR REPLACE FUNCTION is_seller()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users
    WHERE id = auth.uid() AND role = 'seller'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if user is customer
CREATE OR REPLACE FUNCTION is_customer()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users
    WHERE id = auth.uid() AND role = 'customer'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if user owns the resource
CREATE OR REPLACE FUNCTION owns_resource(table_name TEXT, resource_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users
    WHERE id = auth.uid() AND (
      (table_name = 'users' AND id = resource_id) OR
      (table_name = 'user_profiles' AND id = resource_id) OR
      (table_name = 'addresses' AND user_id = resource_id) OR
      (table_name = 'payment_methods' AND user_id = resource_id) OR
      (table_name = 'products' AND seller_id = resource_id) OR
      (table_name = 'orders' AND user_id = resource_id) OR
      (table_name = 'carts' AND user_id = resource_id) OR
      (table_name = 'reviews' AND user_id = resource_id) OR
      (table_name = 'wishlists' AND user_id = resource_id) OR
      (table_name = 'notifications' AND user_id = resource_id)
    )
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create policies for users table
CREATE POLICY "Users can view their own data"
ON users FOR SELECT
USING (id = auth.uid());

CREATE POLICY "Users can update their own data"
ON users FOR UPDATE
USING (id = auth.uid());

CREATE POLICY "Admins can view all users"
ON users FOR SELECT
USING (is_admin());

CREATE POLICY "Admins can update all users"
ON users FOR UPDATE
USING (is_admin());

-- Create policies for user_profiles table
CREATE POLICY "Users can view their own profile"
ON user_profiles FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can update their own profile"
ON user_profiles FOR UPDATE
USING (user_id = auth.uid());

-- Create policies for addresses table
CREATE POLICY "Users can view their own addresses"
ON addresses FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own addresses"
ON addresses FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own addresses"
ON addresses FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY "Users can delete their own addresses"
ON addresses FOR DELETE
USING (user_id = auth.uid());

-- Create policies for payment_methods table
CREATE POLICY "Users can view their own payment methods"
ON payment_methods FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own payment methods"
ON payment_methods FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own payment methods"
ON payment_methods FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY "Users can delete their own payment methods"
ON payment_methods FOR DELETE
USING (user_id = auth.uid());

-- Create policies for products table
CREATE POLICY "Anyone can view active products"
ON products FOR SELECT
USING (status = 'active');

CREATE POLICY "Sellers can view their own products"
ON products FOR SELECT
USING (seller_id = auth.uid());

CREATE POLICY "Sellers can insert their own products"
ON products FOR INSERT
WITH CHECK (seller_id = auth.uid());

CREATE POLICY "Sellers can update their own products"
ON products FOR UPDATE
USING (seller_id = auth.uid());

CREATE POLICY "Sellers can delete their own products"
ON products FOR DELETE
USING (seller_id = auth.uid());

-- Create policies for orders table
CREATE POLICY "Users can view their own orders"
ON orders FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own orders"
ON orders FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Admins can view all orders"
ON orders FOR SELECT
USING (is_admin());

-- Create policies for cart_items table
CREATE POLICY "Users can view their own cart items"
ON cart_items FOR SELECT
USING (cart_id IN (SELECT id FROM carts WHERE user_id = auth.uid()));

CREATE POLICY "Users can insert their own cart items"
ON cart_items FOR INSERT
WITH CHECK (cart_id IN (SELECT id FROM carts WHERE user_id = auth.uid()));

CREATE POLICY "Users can update their own cart items"
ON cart_items FOR UPDATE
USING (cart_id IN (SELECT id FROM carts WHERE user_id = auth.uid()));

CREATE POLICY "Users can delete their own cart items"
ON cart_items FOR DELETE
USING (cart_id IN (SELECT id FROM carts WHERE user_id = auth.uid()));

-- Create policies for reviews table
CREATE POLICY "Anyone can view approved reviews"
ON reviews FOR SELECT
USING (status = 'approved');

CREATE POLICY "Users can view their own reviews"
ON reviews FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own reviews"
ON reviews FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own reviews"
ON reviews FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY "Admins can update all reviews"
ON reviews FOR UPDATE
USING (is_admin());

-- Create policies for wishlists table
CREATE POLICY "Users can view their own wishlists"
ON wishlists FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own wishlists"
ON wishlists FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own wishlists"
ON wishlists FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY "Users can delete their own wishlists"
ON wishlists FOR DELETE
USING (user_id = auth.uid());

-- Create policies for wishlist_items table
CREATE POLICY "Users can view their own wishlist items"
ON wishlist_items FOR SELECT
USING (wishlist_id IN (SELECT id FROM wishlists WHERE user_id = auth.uid()));

CREATE POLICY "Users can insert their own wishlist items"
ON wishlist_items FOR INSERT
WITH CHECK (wishlist_id IN (SELECT id FROM wishlists WHERE user_id = auth.uid()));

CREATE POLICY "Users can delete their own wishlist items"
ON wishlist_items FOR DELETE
USING (wishlist_id IN (SELECT id FROM wishlists WHERE user_id = auth.uid()));

-- Create policies for notifications table
CREATE POLICY "Users can view their own notifications"
ON notifications FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can update their own notifications"
ON notifications FOR UPDATE
USING (user_id = auth.uid());

-- Create trigger to sync auth.users with our users table
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, full_name, role)
  VALUES (new.id, new.email, new.raw_user_meta_data->>'full_name', 'customer');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
