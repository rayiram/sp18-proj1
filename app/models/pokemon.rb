class Pokemon < ApplicationRecord
	# optional:true lets you have wild trainerless pokemon
	belongs_to :trainer, optional: true
	validates :name, presence: true, uniqueness: true
end
