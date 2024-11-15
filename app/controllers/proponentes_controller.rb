class ProponentesController < ApplicationController
  def index
    @proponentes = Proponente.page(params[:page]).per(5)
  end

  def create
    @proponente = Proponente.new(proponente_params)
    if @proponente.save
      salario_liquido = @proponente.salario - inss_discount(@proponente.salario)
      # Enqueue the Sidekiq job after saving the Proponente
      AtualizaSalarioJob.perform_later(@proponente.id, salario_liquido)

      redirect_to proponentes_path, notice: "Proponente cadastrado com sucesso."
    else
      flash.now[:alert] = "Erro ao salvar o proponente. Verifique os campos abaixo."
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @proponente = Proponente.new
  end

  def edit
    @proponente = Proponente.find(params[:id])
  end

  def update
    @proponente = Proponente.find(params[:id])
    if @proponente.update(proponente_params)
      salario_liquido = @proponente.salario - inss_discount(@proponente.salario)
      # Enqueue the Sidekiq job after updating the Proponente
      AtualizaSalarioJob.perform_later(@proponente.id, salario_liquido)

      redirect_to proponentes_path, notice: "Proponente atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @proponente = Proponente.find(params[:id])
    @proponente.destroy
    redirect_to proponentes_path, notice: "Proponente excluído com sucesso."
  end

  def calcula_inss
    salario = params[:salario].to_f
    desconto = inss_discount(salario)
    render json: { desconto: desconto }
  end

  def relatorio
    @faixas_salariais = Proponente.salario_faixas.transform_values(&:count)
  end

  def update_salary
    proponente = Proponente.find(params[:id])
    novo_salario = params[:novo_salario].to_f
    salario_liquido = novo_salario - inss_discount(novo_salario)

    AtualizaSalarioJob.perform_later(proponente.id, salario_liquido)
    # Provide feedback to the user
    redirect_to proponentes_path, notice: "Salário atualizado com sucesso!"
  end

  private

  def inss_discount(salario)
    case salario
    when 0..1045
      salario * 0.075
    when 1045.01..2089.60
      (1045 * 0.075) + ((salario - 1045) * 0.09)
    when 2089.61..3134.40
      (1045 * 0.075) + ((2089.60 - 1045) * 0.09) + ((salario - 2089.60) * 0.12)
    else
      (1045 * 0.075) + ((2089.60 - 1045) * 0.09) + ((3134.40 - 2089.60) * 0.12) + ((salario - 3134.40) * 0.14)
    end
  end

  def proponente_params
    params.require(:proponente).permit(:nome, :cpf, :data_nascimento, :endereco, :bairro, :cidade, :estado, :cep, :telefone, :salario)
  end
end
