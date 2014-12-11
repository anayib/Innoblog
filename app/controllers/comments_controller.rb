class CommentsController < ApplicationController

	 def create
    @article = Article.find(params[:article_id])

    @comment = @article.comments.create(comment_params)    
    # @comment = Comment.new(comment_params)
    # @comment.article_id = params[:article_id]
    # @comment.save

    redirect_to article_path(@article)
    #esto sería lo mismo que  redirect_to article_path(@article.id)
    #porque en la route es: article GET /articles/:id(.:format) - articles#show , 
    #pero no es necesario el .id porque rails por convención lo entiende
   end
 
  private
    def comment_params
      # {
      #   comment: {
      #     commenter: 'xxx',
      #     body: 'yyy'
      #   }
      # }
      params.require(:comment).permit(:commenter, :body)
    end

end
