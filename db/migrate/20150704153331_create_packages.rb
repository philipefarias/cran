class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name,      null: false
      t.string :version,   null: false
      t.date :publication, null: false
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
