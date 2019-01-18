class Hero < ActiveRecord::Base
    belongs_to :user, :allow_destroy => true
end