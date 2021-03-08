class Like < ApplicationRecord
    belongs_to :user
    belongs_to :picture
    validates_uniqueness_of :picture_id, scope: :user_id
end
