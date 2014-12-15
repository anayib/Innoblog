class CommentsController < ApplicationController

  def index

    @article = Article.find(params[:article_id])

  end


  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
     # @comment = Comment.new(comment_params)
    # @comment.article_id = params[:article_id]
    # @comment.save
    @comment.user_id = current_user.id

    @comment.save

    redirect_to article_path(@article)
    #esto sería lo mismo que  redirect_to article_path(@article.id)
    #porque en la route es: article GET /articles/:id(.:format) - articles#show ,
    #pero no es necesario el .id porque rails por convención lo entiende

  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end


  private

    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end