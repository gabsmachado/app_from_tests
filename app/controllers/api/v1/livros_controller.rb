module Api
  module V1
    class LivrosController < ApplicationController
      before_action :set_livro, only: [:show, :update, :destroy]

      # GET /api/v1/livros
      def index
        @livros = Livro.all
        render json: @livros
      end

      # GET /api/v1/livros/:id
      def show
        render json: @livro
      end

      # POST /api/v1/livros
      def create
        @livro = Livro.new(livro_params)

        if @livro.save
          render json: @livro, status: :created
        else
          render json: @livro.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/livros/:id
      def update
        if @livro.update(livro_params)
          render json: @livro
        else
          render json: @livro.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/livros/:id
      def destroy
        @livro.destroy
        head :no_content
      end

      private

      # Método que encontra um livro pelo id fornecido
      def set_livro
        @livro = Livro.find(params[:id])
      end

      # Strong params para permitir parâmetros seguros
      def livro_params
        params.require(:livro).permit(:titulo, :autor, :descricao, :publicado_em)
      end
    end
  end
end
