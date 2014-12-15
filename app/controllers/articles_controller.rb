class ArticlesController < ApplicationController

  def index
    @articles=Article.all
    @articlesOrdered = @articles.order('created_at DESC')

    @comments_per_article = Article.joins(:comments).group(:article_id).order('count_all DESC').limit(2).count

    #@comments_ordered = comments_per_artilce.sort{ |x,y| y<=>x }

    Article.joins(:comments).group(:article_id).order('count_all desc').count

    #Estas líneas hacen lo mismo que el join de arriba
    #se está haciendo manualmente la creación de un
    #hash y se está ordenando de mayor a menor

    # #@article_hash = Hash.new

    # @articles.each do |article|
    #   @numbre_of_comments = article.comments.count
    #   @article_hash[article.id]= @numbre_of_comments
    # end
    # @article_hash.sort{ |x,y| y<=>x }

  end

  def new
    @article = Article.new
  end

  def create

    @article = Article.new(article_params)
    @article.user_id = current_user.id
     if @article.save
    redirect_to @article #es un shortcut para article_path(@article)
    else
    render 'new'
    end
  end

  def edit
  @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end





  private

  def article_params

    params.require(:article).permit(:title, :text, :date)

  end
 end

