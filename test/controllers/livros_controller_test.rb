require "test_helper"

class LivrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @livro = livros(:one) # Criado automaticamente pelo arquivo de fixtures
  end

  test "deve acessar index" do
    get livros_url
    assert_response :success
  end

  test "deve acessar novo" do
    get new_livro_url
    assert_response :success
  end

  test "deve criar livro" do
    assert_difference('Livro.count') do
      post livros_url, params: { livro: { titulo: "Novo Livro", autor: "Autor Novo", publicado_em: "2021-09-01", descricao: "Descrição do livro" } }
    end

    assert_redirected_to livro_url(Livro.last)
  end

  test "deve mostrar livro" do
    get livro_url(@livro)
    assert_response :success
  end

  test "deve acessar editar" do
    get edit_livro_url(@livro)
    assert_response :success
  end

  test "deve atualizar livro" do
    patch livro_url(@livro), params: { livro: { titulo: "Livro Atualizado", autor: "Autor Atualizado" } }
    assert_redirected_to livro_url(@livro)
  end

  test "deve destruir livro" do
    assert_difference('Livro.count', -1) do
      delete livro_url(@livro)
    end

    assert_redirected_to livros_url
  end
end
