class Proponente < ApplicationRecord
    validates :nome, :cpf, :data_nascimento, :endereco, :salario, presence: true
    validates :cpf, uniqueness: true

    def self.salario_faixas
        {
          'Até R$ 1.045,00' => where(salario: 0..1045),
          'De R$ 1.045,01 a R$ 2.089,60' => where(salario: 1045.01..2089.6),
          'De R$ 2.089,61 até R$ 3.134,40' => where(salario: 2089.61..3134.4),
          'De R$ 3.134,41 até R$ 6.101,06' => where(salario: 3134.41..6101.06)
        }
      end
end
