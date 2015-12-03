class CommentsController < ApplicationController
	before_action :set_post

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "Oh snap!"
			redirect_to :back
		else
			flash[:alert] = "how'd you mess that up?"
			render root_path
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])

		@comment.destroy
		flash[:success] = "You know? Someone still could have screen capped that... just sayin'."
		redirect_to root_path 
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_post
		@post = Post.find(params[:post_id])
	end
end