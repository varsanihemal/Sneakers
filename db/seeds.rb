# Clear existing data
ProductImage.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all
AdminUser.destroy_all if Rails.env.development?

# Create provinces
provinces = [
  { name: "Alberta" },
  { name: "British Columbia" },
  { name: "Manitoba" },
  { name: "New Brunswick" },
  { name: "Newfoundland and Labrador" },
  { name: "Northwest Territories" },
  { name: "Nova Scotia" },
  { name: "Nunavut" },
  { name: "Ontario" },
  { name: "Prince Edward Island" },
  { name: "Quebec" },
  { name: "Saskatchewan" },
  { name: "Yukon" }
]

provinces.each do |province_data|
  Province.find_or_create_by!(name: province_data[:name])
end

# Create categories
categories = ["Casual", "Sports"]
categories.each do |category_name|
  Category.create!(name: category_name)
end

# Create products
products = [
  { name: "Nike Air Max", description: "Comfortable and stylish sports shoes.", price: 129.99, category_name: "Casual", image_url: "airmax.jpeg" },
  { name: "Custom", description: "High-performance running shoes.", price: 179.99, category_name: "Casual", image_url: "image-product-1.jpg" },
  { name: "Puma Classic", description: "Classic sports shoes.", price: 89.99, category_name: "Sports", image_url: "puma_classic.jpg" },
  { name: "Reebok Sports", description: "Durable and lightweight sports shoes.", price: 109.99, category_name: "Sports", image_url: "reebok.jpg" },
  { name: "Converse All Star", description: "Iconic sports shoes.", price: 59.99, category_name: "Sports", image_url: "converse.jpg" },
  { name: "Vans Slip-On", description: "Easy-to-wear sports shoes.", price: 49.99, category_name: "Sports", image_url: "vans.webp" },
  { name: "Nike Air Zoom", description: "High-performance sports shoes.", price: 139.99, category_name: "Sports", image_url: "studs.jpg" },
  { name: "New Balance 990", description: "Comfortable and durable running shoes.", price: 149.99, category_name: "Casual", image_url: "balance.jpeg" },
  { name: "Asics Gel-Kayano", description: "Stability running shoes.", price: 159.99, category_name: "Sports", image_url: "gel.jpg" },
  { name: "Under Armour HOVR", description: "Innovative and stylish running shoes.", price: 129.99, category_name: "Sports", image_url: "under.jpg" }
]

products.each do |product_data|
  category = Category.find_by(name: product_data[:category_name])
  next unless category # Skip if category not found

  new_product = Product.new(
    name: product_data[:name],
    description: product_data[:description],
    price: product_data[:price],
    category: category # Ensure category is correctly set
  )

  # Attach image if it exists
  image_path = Rails.root.join('public', 'images', product_data[:image_url])
  if File.exist?(image_path)
    puts "Attaching image: #{image_path}" # Debug output
    new_product.image.attach(io: File.open(image_path), filename: product_data[:image_url])
  else
    puts "Image not found: #{image_path}" # Debug output
  end

  new_product.save!
end

# Create an admin user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
