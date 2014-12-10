class ArticlesController < ApplicationController
	
  def new

  end

  def create
    render html: params[:article].inspect
    
  end

end
