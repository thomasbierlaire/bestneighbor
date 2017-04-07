class ArticlesController < ApplicationController

  before_action :select_liste_articles, only: [:index]

  def index
    @articles = @liste_articles
  end

  def show
    @id = params[:id]
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit
    end
  end


  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def article_params
    params.require(:article).permit(:nom, :prix, :quantite, :liste_id)
  end

  def select_liste_articles
    @liste_articles = Article.where(liste_id: @liste.id)
  end

end
