json.extract! livro, :id, :titulo, :autor, :descricao, :publicado_em, :created_at, :updated_at
json.url livro_url(livro, format: :json)
