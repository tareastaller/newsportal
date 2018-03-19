class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :nombre
      t.text :contenido

      t.timestamps
    end
  end
end
