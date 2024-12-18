# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

10.times do
  Proponente.create!(
    nome: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number,
    data_nascimento: Faker::Date.birthday(min_age: 18, max_age: 65),
    endereco: Faker::Address.street_address,
    bairro: Faker::Address.community,
    cidade: Faker::Address.city,
    estado: Faker::Address.state_abbr,
    cep: Faker::Address.zip_code,
    telefone: Faker::PhoneNumber.phone_number,
    numero: Faker::Address.building_number,
    salario: rand(1000.0..6000.0).round(2)
  )
end
