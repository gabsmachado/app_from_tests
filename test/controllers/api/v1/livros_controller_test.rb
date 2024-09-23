require 'test_helper'

module Api
  module V1
    class LivrosControllerTest < ActionDispatch::IntegrationTest
      setup do
        @livro = livros(:one) # Usando o fixture "one" de livros
      end

      # Testa a listagem de todos os livros (GET /api/v1/livros)
      test "deve listar todos os livros" do
        get api_v1_livros_url, as: :json
        assert_response :success

        # Verifica se a resposta JSON contém a lista de livros
        json_response = JSON.parse(response.body)
        assert json_response.is_a?(Array)
        assert_equal Livro.count, json_response.size
      end

      # Testa a exibição de um livro específico (GET /api/v1/livros/:id)
      test "deve mostrar um livro" do
        get api_v1_livro_url(@livro), as: :json
        assert_response :success

        # Verifica se a resposta JSON contém os dados corretos
        json_response = JSON.parse(response.body)
        assert_equal @livro.titulo, json_response["titulo"]
        assert_equal @livro.autor, json_response["autor"]
      end

      # Testa a criação de um novo livro (POST /api/v1/livros)
      test "deve criar um livro" do
        assert_difference('Livro.count') do
          post api_v1_livros_url, params: {
            livro: {
              titulo: "O Hobbit",
              autor: "J.R.R. Tolkien",
              publicado_em: "1937-09-21",
              descricao: "Uma jornada épica."
            }
          }, as: :json
        end
        assert_response :created

        # Verifica se o novo livro foi criado com os atributos corretos
        json_response = JSON.parse(response.body)
        assert_equal "O Hobbit", json_response["titulo"]
        assert_equal "J.R.R. Tolkien", json_response["autor"]
      end

      # Testa a atualização de um livro existente (PATCH/PUT /api/v1/livros/:id)
      test "deve atualizar um livro" do
        patch api_v1_livro_url(@livro), params: {
          livro: {
            titulo: "O Hobbit Atualizado",
            autor: "J.R.R. Tolkien"
          }
        }, as: :json
        assert_response :success

        # Verifica se o livro foi atualizado corretamente
        @livro.reload
        assert_equal "O Hobbit Atualizado", @livro.titulo
      end

      # Testa a exclusão de um livro (DELETE /api/v1/livros/:id)
      test "deve excluir um livro" do
        assert_difference('Livro.count', -1) do
          delete api_v1_livro_url(@livro), as: :json
        end
        assert_response :no_content
      end

      # Testa a tentativa de criação com parâmetros inválidos
      test "não deve criar livro com parâmetros inválidos" do
        assert_no_difference('Livro.count') do
          post api_v1_livros_url, params: {
            livro: {
              titulo: "", # Título inválido
              autor: "",
              publicado_em: "2022-09-15"
            }
          }, as: :json
        end
        assert_response :unprocessable_entity

        # Verifica se a resposta contém os erros
        json_response = JSON.parse(response.body)
        assert json_response["titulo"].include?("can't be blank")
        assert json_response["autor"].include?("can't be blank")
      end
    end
  end
end
