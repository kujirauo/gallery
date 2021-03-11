class Picture < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    attachment :image

    #has_many :liked_users, through: :likes, source: :user
    #picturesテーブルから中間テーブルに対する関連付け
    #has_many :picture_tag_relations, dependent: :destroy
    #picturesテーブルから中間テーブルを介してTagsテーブルへの関連付け
    #has_many :tags, through: :picture_tag_relations, dependent: :destroy
    
    

    with_options presence: true do
        validates :title
        validates :body
        validates :image
    end

    def user
        return User.find_by(id: self.user_id)
    end

    def self.search(search)
        if search
            Picture.where(['content LIKE ?', "%#{search}%"])
        else
            Picture.all
        end
    end
end
