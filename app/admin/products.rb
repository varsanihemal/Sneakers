ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id,
                product_images_attributes: [:id, :image, :_destroy]

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
    end

    f.inputs 'Product Images' do
      f.has_many :product_images, allow_destroy: true, new_record: true, heading: 'Images' do |image_form|
        image_form.input :image, as: :file, hint: image_form.object.image.attached? ? image_tag(image_form.object.image) : content_tag(:span, 'No image uploaded')
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :category
    actions
  end

  filter :name
  filter :price
  filter :category
end
