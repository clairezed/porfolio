class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :teaser
      t.text :description
      t.date :deployed_at
      t.string :category
      t.string :link
      t.integer :position
      t.boolean :highlighted, default: false
      t.boolean :visible, default: true
      t.string :slug
      t.string :seo_title
      t.string :seo_keywords
      t.text :seo_description
      t.timestamps
    end
  end
end
