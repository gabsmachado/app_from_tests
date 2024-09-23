require 'rails_helper'

RSpec.describe "Artciles", type: :request do
  describe "GET /articles" do
    it "retorna sucesso" do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end
end
