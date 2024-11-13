class CreateProponentes < ActiveRecord::Migration[7.2]
  def change
    create_table :proponentes do |t|
      t.string :nome
      t.string :cpf
      t.date :data_nascimento
      t.string :endereco
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :cep
      t.string :numero
      t.string :telefone
      t.decimal :salario, precision: 10, scale: 2
      t.timestamps
    end
  end
end
