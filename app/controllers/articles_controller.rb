class ArticlesController < ApplicationController

  def index
    @articles=Article.all
    @articlesOrdered = @articles.order('created_at DESC')


    @articles.each do |article|

      @numbre_of_comments = article.comments.count
      @article_hash = Hash.new
      @article_hash[:article_id]= @numbre_of_comments
      @article.hash{ |x,y| y<=>x }
    end
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

