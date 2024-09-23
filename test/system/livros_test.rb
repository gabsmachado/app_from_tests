require "application_system_test_case"

class LivrosTest < ApplicationSystemTestCase
  setup do
    @livro = livros(:one)
  end

  test "visitando o índice de livros" do
    visit livros_url
    assert_selector "h1", text: "Lista de Livros"
  end

  test "criando um livro" do
    visit livros_url
    click_on "Novo Livro"

    fill_in "Titulo", with: "Novo Livro de Teste"
    fill_in "Autor", with: "Autor de Teste"
    fill_in "Publicado em", with: "2021-09-01"
    fill_in "Descricao", with: "Descrição de teste"
    click_on "Create Livro"

    assert_text "Livro foi criado com sucesso."
    click_on "Voltar para a Lista"
  end

  test "atualizando um livro" do
    visit livros_url
    click_on "Editar", match: :first

    fill_in "Titulo", with: "Título Atualizado"
    fill_in "Autor", with: "Autor Atualizado"
    click_on "Update Livro"

    assert_text "Livro foi atualizado com sucesso."
    click_on "Voltar para a Lista"
  end

  test "destruindo um livro" do
    visit livros_url
    page.accept_confirm do
      click_on "Deletar", match: :first
    end

    assert_text "Livro foi excluído com sucesso."
  end
end
