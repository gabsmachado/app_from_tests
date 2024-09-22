class CreateLivros < ActiveRecord::Migration[6.1]
  def change
    create_table :livros do |t|
      t.string :titulo
      t.string :autor
      t.text :descricao
      t.date :publicado_em

      t.timestamps
    end
  end
end
