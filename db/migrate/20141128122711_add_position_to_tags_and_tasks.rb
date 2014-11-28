class AddPositionToTagsAndTasks < ActiveRecord::Migration
  def change
    add_column :project_tags, :position,   :integer
    add_column :project_tasks, :position,   :integer
  end
end
