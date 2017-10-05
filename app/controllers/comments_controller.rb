class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@article = Article.find(params[:article_id]) 
	end

	def create
		@comment = Comment.new(comment_params)
		byebug
		if @comment.save
			redirect_to article_path(@comment.article.id)
			flash[:success] = "Created the comments!"
		else
			render "new"
			flash[:notice] = "Didnt work"
		end
	end

	def show
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
	end

	def edit
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id]) 
	end

	def update
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			flash[:success] = "Comment is updated successfully."
			redirect_to article_path(@article)
		else
			flash[:danger] = "Error updating comment."
			render 'edit'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:reply_article, :user_id, :article_id)
	end
end
