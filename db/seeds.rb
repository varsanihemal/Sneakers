begin
  ActiveRecord::Base.transaction do
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
      { name: "Northwest Territories", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
      { name: "Nova Scotia", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.15 },
      { name: "Nunavut", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
      { name: "Ontario", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.13 },
      { name: "Prince Edward Island", gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.15 },
      { name: "Quebec", gst_rate: 0.05, pst_rate: 0.09975, hst_rate: 0.00 },
      { name: "Saskatchewan", gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.00 },
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
    categories = ["Men", "Women", "Kids", "Sports"]
    categories.each do |category_name|
      Category.create!(name: category_name)
    end

    # Products
    products = [
  # Men
  { name: "Adidas Adizero Boston 12", description: "High-performance running shoes with lightweight design and excellent cushioning.", price: 139.99, category_name: "Men", image_url: "AdizeroBoston12.jpg" },
  { name: "Nike Giannis Immortality", description: "Versatile basketball shoes designed for comfort and style on and off the court.", price: 159.99, category_name: "Men", image_url: "giannis.png" },
  { name: "Puma Retrocross", description: "Retro-inspired sneakers with a comfortable fit and bold style.", price: 99.99, category_name: "Men", image_url: "Retrocross.jpg" },
  { name: "Adidas Supernova Stride", description: "Durable running shoes with a supportive fit and responsive cushioning.", price: 119.99, category_name: "Men", image_url: "SupernovaStride.jpg" },
  { name: "Adidas Terrex Free Hiker", description: "All-terrain hiking shoes with a flexible fit and superior grip.", price: 189.99, category_name: "Men", image_url: "TerrexFreeHiker.jpg" },

  # Women
  { name: "Adidas Advantage 2.0", description: "Classic tennis shoes with a clean design and comfortable fit.", price: 79.99, category_name: "Women", image_url: "Advantage_2.0.jpg" },
  { name: "Adidas Crazyflight", description: "Performance volleyball shoes with lightweight design and cushioned support.", price: 139.99, category_name: "Women", image_url: "Crazyflight.jpg" },
  { name: "Adidas Supernova Rise", description: "Running shoes designed for a smooth and responsive ride.", price: 119.99, category_name: "Women", image_url: "Supernova_rise_running.jpg" },
  { name: "Adidas Terrex Agravic Flow", description: "Trail running shoes with breathable mesh and a rugged outsole.", price: 129.99, category_name: "Women", image_url: "Terrex_Agravic_Flow.jpg" },
  { name: "Adidas VLcourt", description: "Casual sneakers with retro style and comfortable cushioning.", price: 69.99, category_name: "Women", image_url: "VLcourt.jpg" },

  # Kids
  { name: "Adidas Disney", description: "Fun and colorful sneakers for kids featuring Disney characters.", price: 79.99, category_name: "Kids", image_url: "adidasdisney.jpg" },
  { name: "Adidas Disney 2", description: "Additional Disney-themed sneakers with vibrant designs for kids.", price: 89.99, category_name: "Kids", image_url: "adidasdisney2.jpg" },
  { name: "Adidas Duramo SL", description: "Comfortable running shoes with a breathable mesh upper and supportive sole.", price: 69.99, category_name: "Kids", image_url: "Duramo_SL_Shoes.jpg" },
  { name: "Reebok Messi", description: "Soccer-inspired sneakers for kids with a stylish design.", price: 99.99, category_name: "Kids", image_url: "messi.jpg" },
  { name: "Adidas VL Court 3.0", description: "Classic and versatile sneakers with a simple design and durable construction.", price: 59.99, category_name: "Kids", image_url: "VL_Court_3.0.jpg" },

  # Sports
  { name: "Air Jordan Golf", description: "Performance golf shoes with a sleek design and excellent traction.", price: 159.99, category_name: "Sports", image_url: "airjordangolf.png" },
  { name: "Air Jordan Mule", description: "Casual yet sporty mule shoes with a recognizable design.", price: 129.99, category_name: "Sports", image_url: "airjordanmule.png" },
  { name: "Asics F30 Firm Ground", description: "Soccer cleats designed for firm ground with excellent control and comfort.", price: 149.99, category_name: "Sports", image_url: "f30.jpg" },
  { name: "Under Armour HOVR", description: "Innovative running shoes with cushioning technology for a smooth ride.", price: 139.99, category_name: "Sports", image_url: "gtcut3.png" },
  { name: "Vans Hustle", description: "Casual and stylish sneakers with a durable design suitable for various activities.", price: 79.99, category_name: "Sports", image_url: "gthustle3.png" }
]

    products.each do |product_data|
      category = Category.find_by(name: product_data[:category_name])
      next unless category # Skip if category not found

      new_product = Product.create!(
        name:        product_data[:name],
        description: product_data[:description],
        price:       product_data[:price],
        category:    category
      )

      # Attach image if it exists
      image_path = Rails.root.join("app/assets/images", product_data[:image_url])
      if File.exist?(image_path)
        Rails.logger.debug "Attaching image: #{image_path}" # Debug output
        ProductImage.create!(
          product: new_product,
          image:   File.open(image_path)
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
  end
rescue => e
  Rails.logger.error "Seed failed: #{e.message}"
  raise e
end
