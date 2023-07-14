class CreateLearning < ActiveRecord::Migration[6.1]
  def change
    create_table :learnings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :author, null: false
      t.string :reference_link
      t.string :image_link

      t.timestamps
    end
  end
end
