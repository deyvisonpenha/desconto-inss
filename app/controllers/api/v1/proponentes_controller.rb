module Api
  module V1
    class ProponentesController < ApplicationController
      def index
        # @proponentes = Proponente.page(params[:page]).per(5)
        render json: Proponente.page(params[:page]).per(5)
      end

      def create
        proponente = Proponente.new(proponente_params)

        if proponente.save
          render json: proponente, status: :created
        end
      end

      def new
      end

      def edit
      end

      def show
      end

      def update
      end

      def destroy
      end
      
      private

      def proponente_params
        params.require(:proponente).permit(:nome, :cpf, :data_nascimento, :endereco, :bairro, :cidade, :estado, :cep, :telefone, :salario)
      end
    
    end
  end
end
