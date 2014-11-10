class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.timestamps
    end

    create_table :project_tags do |t|
      t.integer :tag_id
      t.integer :project_id
      t.timestamps
    end
  end
end
