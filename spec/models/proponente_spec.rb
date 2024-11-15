require 'rails_helper'

RSpec.describe Proponente, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      proponente = Proponente.new(
        nome: 'John Doe',
        cpf: '12345678901',
        data_nascimento: '1990-01-01',
        endereco: '123 Street',
        salario: 1500.00
      )
      expect(proponente).to be_valid
    end

    it 'is invalid without a nome' do
      proponente = Proponente.new(nome: nil)
      proponente.valid?
      expect(proponente.errors[:nome]).to include("can't be blank")
    end

    it 'is invalid without a cpf' do
      proponente = Proponente.new(cpf: nil)
      proponente.valid?
      expect(proponente.errors[:cpf]).to include("can't be blank")
    end

    it 'is invalid without a salario' do
      proponente = Proponente.new(salario: nil)
      proponente.valid?
      expect(proponente.errors[:salario]).to include("can't be blank")
    end

    it 'is invalid with a duplicate cpf' do
      Proponente.create(
        nome: 'John Doe',
        cpf: '12345678901',
        data_nascimento: '1990-01-01',
        endereco: '123 Street',
        salario: 1500.00
      )
      proponente = Proponente.new(
        nome: 'Jane Doe',
        cpf: '12345678901',
        data_nascimento: '1992-01-01',
        endereco: '456 Avenue',
        salario: 2000.00
      )
      proponente.valid?
      expect(proponente.errors[:cpf]).to include("has already been taken")
    end
  end

  describe '.salario_faixas' do
    it 'returns the correct salary ranges' do
      faixa = Proponente.salario_faixas
      expect(faixa['Até R$ 1.045,00']).to be_a(ActiveRecord::Relation)
      expect(faixa['De R$ 1.045,01 a R$ 2.089,60']).to be_a(ActiveRecord::Relation)
    end
  end
end
