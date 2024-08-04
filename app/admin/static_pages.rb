ActiveAdmin.register StaticPage do
  permit_params :title, :content

  # Form Configuration
  form do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :content, as: :text, input_html: { rows: 10 } # Adjust rows as needed
    end
    f.actions
  end

  # Index Page Configuration
  index do
    selectable_column
    id_column
    column :title
    column :content do |static_page|
      truncate(static_page.content, length: 50) # Truncate for readability
    end
    actions
  end

  # Filters for Index Page
  filter :title
  filter :created_at

  # Optional: Custom Actions
  member_action :publish, method: :put do
    resource.update(published: true)
    redirect_to collection_path, notice: "Page published!"
  end

  collection_action :archive, method: :delete do
    StaticPage.where(published: false).destroy_all
    redirect_to collection_path, notice: "Unpublished pages archived."
  end

  # Optional: Customizing Show Page (if needed)
  show do
    attributes_table do
      row :title
      row :content do |static_page|
        raw static_page.content # Use raw for HTML content, if applicable
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
