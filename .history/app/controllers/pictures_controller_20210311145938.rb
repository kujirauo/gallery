class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @pictures = Picture.all.order(created_at: :desc)
    #@picture = Picture.find_by(id: params[:id])
    #@q = current_user.pictures.ransack(params[:q])
    #@pictures = @q.result(distinct: true).page(params[:page])
    #@pictures = @q.result(distinct: true)
    #picturesの一覧が消える
    @tags = Pic.tag_counts_on(:tags).most_used(20)
    if params[:tag_name]
      @pictures = Picture.tagged_with("#{params[:tag_name]}")
    end
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

  #def search
  #  if params[:name].present?
  #    @pictures = picture.where('name LIKE ?', "%#{params[:name]}%")
  #  else
  #    @pictures = picture.none
  #  end
    #@pictures = Picture.search(params[:search])
    #@q = Picture.search(search_params)
  #  #@pictures = @q.result(distinct: true)

  private

  def picture_params
    params.require(:picture).permit(:title, :body, :image, :tag_list)
    #tag_list を追加
  end

  #def search_params
  #  params.require(:q).permit!
  #end
end
