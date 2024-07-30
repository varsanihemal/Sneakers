ActiveAdmin.register Order do
  permit_params :user_id, :province_id, :address, :city, :postal_code, :total_amount

  index do
    selectable_column
    id_column
    column :user
    column :address
    column :city
    column :postal_code
    column :province
    column :subtotal
    column :gst
    column :pst
    column :hst
    column :total_amount
    actions
  end

  filter :user
  filter :province
  filter :address
  filter :city
  filter :postal_code
  filter :total_amount
  filter :created_at

  show do
    attributes_table do
      row :user
      row :address
      row :city
      row :postal_code
      row :province
      row :subtotal
      row :gst
      row :pst
      row :hst
      row :total_amount
    end

    panel "Order Items" do
      table_for order.order_items do
        column "Product" do |item|
          item.product.name
        end
        column "Quantity" do |item|
          item.quantity
        end
        column "Price" do |item|
          number_to_currency(item.price_at_purchase)
        end
      end
    end
  end

  form do |f|
    f.inputs 'Order Details' do
      f.input :user
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :province
      f.input :total_amount
    end
    f.actions
  end

end
