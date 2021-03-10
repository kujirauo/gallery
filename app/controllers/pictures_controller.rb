class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @pictures = Picture.all.order(created_at: :desc)
    #@picture = Picture.find_by(id: params[:id])
    @pictures = Picture.where(activated: true).paginate(page: params[:page]).search(params[:search])
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
    @pictures = Picture.search(params[:search])
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :body, :image, :comment)
  end
end
