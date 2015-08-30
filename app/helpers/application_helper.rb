module ApplicationHelper
	# It will help me to define a better msg alert and style
	def flash_class(level)
		case level.to_sym
		when :notice then "alert alert-info"
		when :sucess then "alert alert-sucess"
		when :warning then "alert alert-warning"
		when :danger then "alert alert-danger"
		end
	end
end
