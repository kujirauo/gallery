class Tag < ApplicationRecord
    #Tagsテーブルから中間テーブルに対する関連付け
  has_many :picture_tag_relations, dependent: :destroy
  　#Tagsテーブルから中間テーブルを介してpictureテーブルへの関連付け
    has_many :pictures, through: :picture_tag_relations, dependent: :destroy
end
