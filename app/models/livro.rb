class Livro < ApplicationRecord
  validates :titulo, presence: true
  validates :autor, presence: true
  validates :publicado_em, presence: true
end
