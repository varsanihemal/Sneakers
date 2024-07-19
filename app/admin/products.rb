ActiveAdmin.register Product do
  # Filter configurations
  filter :name
  filter :price
  filter :category
  # For associations, you might need custom filters
  # For example:
  # filter :reviews_comment_cont, as: :string, label: 'Review Comment'
  # filter :product_images_image_url_cont, as: :string, label: 'Image URL'

  # Index page configuration
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :category
    actions
  end
end
