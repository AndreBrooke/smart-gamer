class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@article = Article.find(params[:article_id]) 
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to article_comment_path(@comment.article_id, @comment.id)
			flash[:success] = "Created the comments!"
		else
			render "new"
			flash[:notice] = "Didnt work"
		end
	end

	def show
		@article = Article.find(params[:article_id])
		@comment = Comment.where(article_id: params[:article_id])
	end

	private

	def comment_params
		params.require(:comment).permit(:reply_article, :user_id, :article_id)
	end
end
