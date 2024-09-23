require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'é válido com um título e corpo' do
    article = Article.new(title: 'Título', body: 'Corpo do post')
    expect(article).to be_valid
  end

  it 'não é válido sem título' do
    article = Article.new(title: nil, body: 'Corpo do post')
    expect(article).not_to be_valid
  end
end
