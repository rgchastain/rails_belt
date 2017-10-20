class IdeasController < ApplicationController
	before_action :require_login

	def index
		@user = User.find(current_user)
		@idea = Idea.all
		
	end

	def create
		@idea = Idea.new(idea_params)

		if @idea.save
			flash[:notice] = ["Successfully created idea"]
			return redirect_to ideas_path
		end
		flash[:errors] = @idea.errors.full_messages
		return redirect_to :back
	end

	def destroy
		@idea = Idea.find(params[:id])

		@idea.delete if @idea.user == current_user

		return redirect_to ideas_path(current_user)
	end

	def show
		@user = User.find(params[:id])
		@idea = Idea.find(params[:id])
	end

	private
		def idea_params
			params.require(:idea).permit(:content).merge(user: current_user)
		end
end
