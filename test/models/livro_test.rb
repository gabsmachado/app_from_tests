require "test_helper"

class LivroTest < ActiveSupport::TestCase
  # Testando se o livro pode ser salvo com dados válidos
  test "deve salvar livro válido" do
    livro = Livro.new(titulo: "O Senhor dos Anéis", autor: "J.R.R. Tolkien", publicado_em: "1954-07-29", descricao: "Fantasia épica.")
    assert livro.save
  end

  # Testando se um livro sem título é inválido
  test "não deve salvar livro sem título" do
    livro = Livro.new(autor: "J.R.R. Tolkien", publicado_em: "1954-07-29")
    assert_not livro.save, "Salvou o livro sem um título"
  end

  # Testando se um livro sem autor é inválido
  test "não deve salvar livro sem autor" do
    livro = Livro.new(titulo: "O Senhor dos Anéis", publicado_em: "1954-07-29")
    assert_not livro.save, "Salvou o livro sem um autor"
  end

  # Testando se um livro sem data de publicação é inválido
  test "não deve salvar livro sem data de publicação" do
    livro = Livro.new(titulo: "O Senhor dos Anéis", autor: "J.R.R. Tolkien")
    assert_not livro.save, "Salvou o livro sem data de publicação"
  end
end
