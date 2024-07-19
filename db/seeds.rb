# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Ckear existing data
Category.destroy_all
Product.destroy_all

# Create categories
categories = ["Men's Shoes", "Women's Shoes", "Sports Shoes", "Casual Shoes"]
categories.each do |category|
  Category.create!(name: category)
end

# Create products
products = [
  { name: "Nike Air Max", description: "Comfortable and stylish sports shoes.", price: 129.99, category: Category.find_by(name: "Men's Shoes"), image_url: "nike_air_max.jpg" },
  { name: "Adidas Ultraboost", description: "High-performance running shoes.", price: 179.99, category: Category.find_by(name: "Men's Shoes"), image_url: "adidas_ultraboost.jpg" },
  { name: "Puma Classic", description: "Classic casual shoes.", price: 89.99, category: Category.find_by(name: "Casual Shoes"), image_url: "puma_classic.jpg" },
  { name: "Reebok Sports", description: "Durable and lightweight sports shoes.", price: 109.99, category: Category.find_by(name: "Sports Shoes"), image_url: "reebok_sports.jpg" },
  { name: "Converse All Star", description: "Iconic casual shoes.", price: 59.99, category: Category.find_by(name: "Casual Shoes"), image_url: "converse_all_star.jpg" },
  { name: "Vans Slip-On", description: "Easy-to-wear casual shoes.", price: 49.99, category: Category.find_by(name: "Casual Shoes"), image_url: "vans_slip_on.jpg" },
  { name: "Nike Air Zoom", description: "High-performance sports shoes.", price: 139.99, category: Category.find_by(name: "Sports Shoes"), image_url: "nike_air_zoom.jpg" },
  { name: "New Balance 990", description: "Comfortable and durable running shoes.", price: 149.99, category: Category.find_by(name: "Men's Shoes"), image_url: "new_balance_990.jpg" },
  { name: "Asics Gel-Kayano", description: "Stability running shoes.", price: 159.99, category: Category.find_by(name: "Sports Shoes"), image_url: "asics_gel_kayano.jpg" },
  { name: "Under Armour HOVR", description: "Innovative and stylish running shoes.", price: 129.99, category: Category.find_by(name: "Sports Shoes"), image_url: "under_armour_hovr.jpg" }
]

products.each do |product|
  Product.create!(product)
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
