class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.integer :priority_id
      t.boolean :done
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
