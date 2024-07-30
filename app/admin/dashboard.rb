ActiveAdmin.register_page "Dashboard" do
  content do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        h1 "Welcome to the Admin Dashboard"
        h3 "Total Products: #{Product.count}"
        h3 "Total Categories: #{Category.count}"
        h3 do
          link_to "View All Orders", admin_orders_path, class: "button"
        end
      end
    end
  end
end
