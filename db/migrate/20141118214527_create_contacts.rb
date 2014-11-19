class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :subject
      t.text :message
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
