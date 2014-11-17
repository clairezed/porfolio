class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.timestamps
    end

    create_table :project_tasks do |t|
      t.integer :task_id
      t.integer :project_id
      t.timestamps
    end
  end
end
