class CommentsController < ApplicationController
before_action :find_recipe, only: [:show, :update, :edit, :destroy]
before_action :authenticate_user!, except: [:index, :show]

	def index
		@cook = Cook.find_by_id(params[:id])
		@comments = Comment.where(:cook_id == params[:id]).order("created_at DESC")
	end

	def show

	end

	def new 
		@comment = Comment.create
	end

	def create
		@comment = Comment.create

		if @comment.save
			redirect_to @comment, notice: "Succesfully created new comment"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to @comment
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to root_path, notice: "Successfully deleted the comment"
	end

	private 

	def comment_params
		params.require(:comment).permit(:name, :description, :star, :user_id, :cook_id)
	end

	def find_cook
		@cook = Cook.find(params[:cook_id])
	end
end
