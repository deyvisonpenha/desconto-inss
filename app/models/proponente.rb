class Proponente < ApplicationRecord
    validates :nome, :cpf, :data_nascimento, :endereco, :salario, presence: true
    validates :cpf, uniqueness: true
end
