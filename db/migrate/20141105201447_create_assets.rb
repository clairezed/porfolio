class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :assetable, polymorphic: true
      t.string :asset_file_name
      t.string :asset_content_type
      t.integer :asset_file_size
      t.string :title
      t.integer :position
      t.string :type
      t.string :alt

      t.timestamps
    end
  end
end