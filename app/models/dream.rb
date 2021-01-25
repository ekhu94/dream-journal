class Dream < ActiveRecord::Base
    belongs_to :person
    has_many :entries

end