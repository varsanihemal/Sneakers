ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :image_url

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image_url, as: :file
    end
    f.actions
  end
end
