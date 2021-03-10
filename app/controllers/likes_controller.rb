class LikesController < ApplicationController
    before_action :authenticate_user!
    def create
        @like = current_user.likes.create(picture_id: params[:picture_id])
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        @picture = Picture.find(params[:picture_id])
        @like = current_user.likes.find_by(picture_id: @picture.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end





end

=begin
  def create
        @like = Like.new(user_id: current_user.id, picture_id: params[:picture_id])
        @like.save
        redirect_to("/pictures/#{params[:picture_id]}")
    end

    def destroy
        @picture = Picture.find(params[:picture_id])
        @like = Like.find_by(user_id: current_user.id,picture_id: params[:picture_id])
        @like.destroy
        redirect_to("/pictures/#{params[:picture_id]}")
    end
=end
