class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @pictures = Picture.all.order(created_at: :desc)
    #@picture = Picture.find_by(id: params[:id])
    #@q = Picture.ransack(params[:q])
    #@pictures = @q.result(distinct: true)
    @pictures = Picture.where(activated: true).search(params[:search])
  end

  def show
    @picture = Picture.find_by(id: params[:id])
    @user = @picture.user
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to picture_path(@picture), notice: "画像を投稿しました。"
    else
      render :new
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to picture_path(@picture), notice: "画像を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find_by(id: params[:id])
    @picture.destroy
    redirect_to pictures_path
  end

  def search
    #@q = Picture.search(search_params)
    #@pictures = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit!
  end
end
