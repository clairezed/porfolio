class RenameProjectsLink < ActiveRecord::Migration
  def change
    rename_column :projects, :link, :web_link
  end
end
