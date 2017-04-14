class ArticlesController < ApplicationController

  before_action :select_liste_articles, only: [:index]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :find_liste, only: [:create]

  def index
    @articles = @liste_articles
  end

  def show
    @id = params[:id]
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.liste_id = @liste.id
    if @article.save
      redirect_to new_article_path
    else
      render :new
    end
  end

  def edit

  end

  def update
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

  def find_article
    @article = Article.find(params[:id])
  end

  def find_liste
    @liste = Liste.find_by_user_id(current_user.id)
  end

end
