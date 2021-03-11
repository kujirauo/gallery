class TagList < ApplicationRecord
@picture.tag_list.add("awesome")   # add a single tag. alias for <<
#@picture.tag_list.remove("awesome") # remove a single tag
@picture.save

@picture.skill_list = "joking, clowning, boxing"
@picture.save
@picture.reload
@picture.skills