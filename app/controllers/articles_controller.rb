class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_path
  end

  def show
    @id = params[:id]
    @article = Article.find(params[:id])
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def article_params
    params.require(:article).permit(:nom, :prix, :quantite, :liste_id)
  end

end
