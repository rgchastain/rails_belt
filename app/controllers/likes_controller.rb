class LikesController < ApplicationController
	before_action :require_login
	def create
		idea = Idea.find(params[:id])
		Like.create(user:current_user, idea:idea) unless idea.likers.include? current_user

		return redirect_to ideas_path
	end
end
