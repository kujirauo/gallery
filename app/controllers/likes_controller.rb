class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @like = Like.new(user_id: current_user.id,picture_id: params[:picture_id])
        @like.save
        redirect_to("/pictures/#{params[:picture_id]}")
    end

    def destroy
        @picture = Picture.find(params[:picture_id])
        @like = Like.find_by(user_id: current_user.id,picture_id: params[:picture_id])
        @like.destroy
        redirect_to("/pictures/#{params[:picture_id]}")
    end
end