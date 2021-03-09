class Picture < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    attachment :image

    #has_many :liked_users, through: :likes, source: :user

    with_options presence: true do
        validates :title
        validates :body
        validates :image
    end
end
