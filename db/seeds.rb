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
      { name: "Adidas Adizero Boston 12",
description: "Engineered for high performance, the Adidas Adizero Boston 12 offers a lightweight, responsive design ideal for competitive runners. Featuring Boost cushioning for enhanced energy return and a breathable mesh upper, these shoes ensure maximum comfort and agility during long runs.", price: 139.99, category_name: "Men", image_url: "AdizeroBoston12.jpg" },
      { name: "Nike Giannis Immortality",
description: "Inspired by NBA star Giannis Antetokounmpo, the Nike Giannis Immortality combines style and function with a lightweight design and plush cushioning. The shoe features a durable rubber outsole for excellent traction on various surfaces, making it a versatile choice for both on-court and everyday wear.", price: 159.99, category_name: "Men", image_url: "giannis.png" },
      { name: "Puma Retrocross",
description: "The Puma Retrocross offers a nostalgic design with modern comfort. These retro-inspired sneakers feature a soft, padded collar and a cushioned midsole for all-day wearability. The bold, eye-catching style makes them a standout choice for those who appreciate a classic look with contemporary comfort.", price: 99.99, category_name: "Men", image_url: "Retrocross.jpg" },
      { name: "Adidas Supernova Stride",
description: "Perfect for long-distance runners, the Adidas Supernova Stride combines responsive Boost cushioning with a supportive midfoot lockdown. The durable outsole provides excellent grip on various terrains, while the engineered mesh upper ensures breathability and a snug fit for a smooth running experience.", price: 119.99, category_name: "Men", image_url: "SupernovaStride.jpg" },
      { name: "Adidas Terrex Free Hiker",
description: "Designed for avid hikers, the Adidas Terrex Free Hiker features a rugged outsole with Continental™ Rubber for superior grip on uneven trails. The Boost cushioning provides comfort over long distances, and the flexible, water-resistant upper keeps your feet protected in various weather conditions.", price: 189.99, category_name: "Men", image_url: "TerrexFreeHiker.jpg" },

      # Women
      { name: "Adidas Advantage 2.0",
description: "The Adidas Advantage 2.0 delivers timeless style with a minimalist design. These tennis-inspired shoes feature a soft leather upper for durability and comfort, while the cushioned insole provides a plush step-in feel. Perfect for casual outings or light physical activities.", price: 79.99, category_name: "Women", image_url: "Advantage_2.0.jpg" },
      { name: "Adidas Crazyflight",
description: "Elevate your volleyball game with the Adidas Crazyflight, designed for agility and support. The lightweight construction and Bounce cushioning system offer responsive energy return and impact protection. The breathable upper ensures optimal ventilation, while the grippy outsole provides excellent traction on indoor surfaces.", price: 139.99, category_name: "Women", image_url: "Crazyflight.jpg" },
      { name: "Adidas Supernova Rise",
description: "Experience a superior running experience with the Adidas Supernova Rise. These shoes feature Boost cushioning for a responsive ride and a durable rubber outsole for excellent traction. The engineered mesh upper offers a comfortable fit and breathability, making them ideal for daily runs and workouts.", price: 119.99, category_name: "Women", image_url: "Supernova_rise_running.jpg" },
      { name: "Adidas Terrex Agravic Flow",
description: "Tackle any trail with confidence in the Adidas Terrex Agravic Flow. Designed for trail running, these shoes feature a rugged outsole with multidirectional lugs for enhanced grip. The breathable mesh upper ensures comfort and ventilation, while the cushioned midsole provides a smooth ride on varied terrain.", price: 129.99, category_name: "Women", image_url: "Terrex_Agravic_Flow.jpg" },
      { name: "Adidas VLcourt",
description: "The Adidas VLcourt offers a retro aesthetic with modern comfort. These casual sneakers feature a durable canvas upper and a cushioned midsole for a comfortable fit. The classic design and versatile color options make them a great choice for everyday wear.", price: 69.99, category_name: "Women", image_url: "VLcourt.jpg" },

      # Kids
      { name: "Adidas Disney",
description: "Let your child step into the magic with Adidas Disney sneakers. Featuring vibrant Disney character graphics, these shoes offer a fun and comfortable fit with a cushioned insole and durable outsole. Perfect for everyday adventures and adding a touch of whimsy to their wardrobe.", price: 79.99, category_name: "Kids", image_url: "adidasdisney.jpg" },
      { name: "Adidas Disney 2",
description: "Enhance your child's footwear collection with the Adidas Disney 2 sneakers. These shoes combine playful Disney-themed designs with practical features like a breathable mesh upper and a supportive sole. Ideal for active kids who love expressing their personality through their shoes.", price: 89.99, category_name: "Kids", image_url: "adidasdisney2.jpg" },
      { name: "Adidas Duramo SL",
description: "The Adidas Duramo SL is designed for comfort and breathability. These running shoes feature a mesh upper for ventilation and a cushioned midsole for support. The flexible outsole allows for natural movement, making them perfect for active kids who need reliable footwear for running and play.", price: 69.99, category_name: "Kids", image_url: "Duramo_SL_Shoes.jpg" },
      { name: "Reebok Messi",
description: "Inspired by soccer legend Lionel Messi, the Reebok Messi sneakers offer a stylish and functional design for young athletes. The shoes feature a durable synthetic upper, padded collar, and grippy outsole for traction on various surfaces. Ideal for soccer practice and casual wear.", price: 99.99, category_name: "Kids", image_url: "messi.jpg" },
      { name: "Adidas VL Court 3.0",
description: "The Adidas VL Court 3.0 combines classic style with modern comfort. These sneakers feature a simple yet durable design with a cushioned midsole for all-day comfort. The versatile look makes them suitable for both casual and semi-formal occasions, adding a stylish touch to any outfit.", price: 59.99, category_name: "Kids", image_url: "VL_Court_3.0.jpg" },

      # Sports
      { name: "Air Jordan Golf",
description: "Take your golf game to the next level with the Air Jordan Golf shoes. Designed for optimal performance, these shoes feature a sleek design with a responsive midsole and excellent traction for stability on the course. The stylish look and premium materials ensure you stand out while delivering top-notch performance.", price: 159.99, category_name: "Sports", image_url: "airjordangolf.png" },
      { name: "Air Jordan Mule",
description: "The Air Jordan Mule offers a unique blend of casual comfort and sporty style. These mule shoes feature a cushioned midsole and a distinctive design that makes them a versatile choice for both relaxed and active environments. Ideal for those who appreciate both comfort and a touch of flair.", price: 129.99, category_name: "Sports", image_url: "airjordanmule.png" },
      { name: "Asics F30 Firm Ground",
description: "The Asics F30 Firm Ground cleats are built for soccer players who demand precision and comfort. With a lightweight design and excellent control features, these cleats provide a secure fit and reliable grip on firm ground surfaces. Perfect for enhancing your game on the field.", price: 149.99, category_name: "Sports", image_url: "f30.jpg" },
      { name: "Under Armour HOVR",
description: "Experience the future of running with the Under Armour HOVR shoes. Featuring innovative HOVR cushioning technology, these shoes offer a smooth and responsive ride with energy return. The breathable upper and durable outsole ensure comfort and support for all types of runners.", price: 139.99, category_name: "Sports", image_url: "gtcut3.png" },
      { name: "Vans Hustle",
description: "The Vans Hustle combines casual style with durability, making them perfect for various activities. These sneakers feature a classic design with a reinforced toe and cushioned insole for added comfort. Whether you're skating or just hanging out, these shoes provide a reliable and stylish option.", price: 79.99, category_name: "Sports", image_url: "gthustle3.png" }
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
rescue StandardError => e
  Rails.logger.error "Seed failed: #{e.message}"
  raise e
end
