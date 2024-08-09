# Clear existing data
ProductImage.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all
AdminUser.destroy_all if Rails.env.development?

# Create provinces with tax rates
provinces = [
  { name: "Alberta", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
  { name: "British Columbia", gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.00 },
  { name: "Manitoba", gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.00 },
  { name: "New Brunswick", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.15 },
  { name: "Newfoundland and Labrador", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.15 },
  { name: "Nova Scotia", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.15 },
  { name: "Ontario", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.13 },
  { name: "Prince Edward Island", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.10 },
  { name: "Quebec", gst_rate: 0.05, pst_rate: 0.10, hst_rate: 0.00 },
  { name: "Saskatchewan", gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.00 },
  { name: "Northwest Territories", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
  { name: "Nunavut", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
  { name: "Yukon", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 }
]

provinces.each do |province_data|
  Province.find_or_create_by!(name: province_data[:name]) do |province|
    province.gst_rate = province_data[:gst_rate]
    province.pst_rate = province_data[:pst_rate]
    province.hst_rate = province_data[:hst_rate]
  end
end

# Create categories
categories = ["Casual", "Sports"]
categories.each do |category_name|
  Category.create!(name: category_name)
end

# Create products
products = [
  { name: "Nike Air Max", description: "Comfortable and stylish sports shoes.", price: 129.99,
category_name: "Casual", image_url: "airmax.jpeg" },
  { name: "Custom", description: "High-performance running shoes.", price: 179.99,
category_name: "Casual", image_url: "image-product-1.jpg" },
  { name: "Puma Classic", description: "Classic sports shoes.", price: 89.99,
category_name: "Sports", image_url: "puma_classic.jpg" },
  { name: "Reebok Sports", description: "Durable and lightweight sports shoes.", price: 109.99,
category_name: "Sports", image_url: "reebok.jpg" },
  { name: "Converse All Star", description: "Iconic sports shoes.", price: 59.99,
category_name: "Sports", image_url: "converse.jpg" },
  { name: "Vans Slip-On", description: "Easy-to-wear sports shoes.", price: 49.99,
category_name: "Sports", image_url: "vans.webp" },
  { name: "Nike Air Zoom", description: "High-performance sports shoes.", price: 139.99,
category_name: "Sports", image_url: "studs.jpg" },
  { name: "New Balance 990", description: "Comfortable and durable running shoes.", price: 149.99,
category_name: "Casual", image_url: "balance.jpeg" },
  { name: "Asics Gel-Kayano", description: "Stability running shoes.", price: 159.99,
category_name: "Sports", image_url: "gel.jpg" },
  { name: "Under Armour HOVR", description: "Innovative and stylish running shoes.", price: 129.99,
category_name: "Sports", image_url: "under.jpg" }
]

products.each do |product_data|
  category = Category.find_by(name: product_data[:category_name])
  next unless category # Skip if category not found

  new_product = Product.create!(
    name:        product_data[:name],
    description: product_data[:description],
    price:       product_data[:price],
    category:
  )

  # Attach image if it exists
  image_path = Rails.root.join("app/assets/images", product_data[:image_url])
  if File.exist?(image_path)
    Rails.logger.debug "Attaching image: #{image_path}" # Debug output
    ProductImage.create!(
      product: new_product,
      image:   Rails.root.join("app/assets/images", product_data[:image_url]).open
    )
  else
    Rails.logger.debug "Image not found: #{image_path}" # Debug output
  end
end

# Create an admin user
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end
