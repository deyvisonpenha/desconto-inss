require 'rails_helper'

RSpec.describe ProponentesController, type: :controller do
  let(:valid_attributes) {
    {
      nome: 'John Doe',
      cpf: '12345678901',
      data_nascimento: '1990-01-01',
      endereco: '123 Street',
      salario: 1500.00
    }
  }

  let(:invalid_attributes) {
    {
      nome: nil,
      cpf: '12345678901',
      data_nascimento: '1990-01-01',
      endereco: '123 Street',
      salario: 1500.00
    }
  }

  describe 'GET #index' do
    it 'assigns @proponentes' do
      proponente = Proponente.create(valid_attributes)
      get :index
      expect(assigns(:proponentes)).to eq([ proponente ])
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Proponente and redirects' do
        expect {
          post :create, params: { proponente: valid_attributes }
        }.to change(Proponente, :count).by(1)
        expect(response).to redirect_to(proponentes_path)
        expect(flash[:notice]).to eq('Proponente cadastrado com sucesso.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Proponente and re-renders the :new template' do
        expect {
          post :create, params: { proponente: invalid_attributes }
        }.to change(Proponente, :count).by(0)
        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to eq('Erro ao salvar o proponente. Verifique os campos abaixo.')
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested proponente to @proponente' do
      proponente = Proponente.create(valid_attributes)
      get :edit, params: { id: proponente.id }
      expect(assigns(:proponente)).to eq(proponente)
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the requested proponente and redirects' do
        proponente = Proponente.create(valid_attributes)
        patch :update, params: { id: proponente.id, proponente: { nome: 'Updated Name' } }
        proponente.reload
        expect(proponente.nome).to eq('Updated Name')
        expect(response).to redirect_to(proponentes_path)
        expect(flash[:notice]).to eq('Proponente atualizado com sucesso.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the proponente and re-renders the :edit template' do
        proponente = Proponente.create(valid_attributes)
        patch :update, params: { id: proponente.id, proponente: { nome: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested proponente and redirects' do
      proponente = Proponente.create(valid_attributes)
      expect {
        delete :destroy, params: { id: proponente.id }
      }.to change(Proponente, :count).by(-1)
      expect(response).to redirect_to(proponentes_path)
      expect(flash[:notice]).to eq('Proponente excluído com sucesso.')
    end
  end

  describe 'GET #calcula_inss' do
    it 'returns the correct inss discount' do
      proponente = Proponente.create(valid_attributes)  # Create a Proponente with valid attributes
      get :calcula_inss, params: { id: proponente.id, salario: 1500.00 }
      expect(response.body).to include('desconto')
    end
  end
end
