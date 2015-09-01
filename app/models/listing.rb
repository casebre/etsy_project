class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "me.jpg"
		#remember to change me.jpg :/
	else	
		has_attached_file :image, 
			:styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "me.jpg",
			:storage => :dropbox,
			:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
			:path => ":style/:id_filename"
	end

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_presence :image
	validates :name, :description, :price, presence: true
	validates :price, numericality: {greater_than: 0}
end
