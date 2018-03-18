class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :titular
      t.text :bajada
      t.text :cuerpo

      t.timestamps
    end
  end
end
