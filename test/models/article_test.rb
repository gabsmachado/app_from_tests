require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'é válido com um título e corpo' do
    post = Post.new(title: 'Título', body: 'Corpo do post')
    expect(post).to be_validru
  end

  it 'não é válido sem título' do
    post = Post.new(title: nil, body: 'Corpo do post')
    expect(post).not_to be_valid
  end
end
