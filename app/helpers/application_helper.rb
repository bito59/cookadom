module ApplicationHelper

	def xeditable? object = nil
  		true # Or something like current_user.xeditable?
  		#xeditable = true
	end

	def flash_message (type, text)
	    flash[type] ||= []
	    flash[type] << text
	end

	def render_flash
		rendered = []
  		flash.each do |type, msg|
  			if msg.class == Array
  				msg.each do |message|
  					content = ""
  					if message.class == Array
  						content = message[0].to_s + " " + message[1][0].to_s
  					else
  						content = message
  					end
  					rendered << content_tag(:div, content, class: "flash_#{type}")
  				end
  			else
  				rendered << content_tag(:div, msg, class: "flash_#{type}")   			
  			end
	  	end
		rendered.join().html_safe
	end	

	def flash_class(level)
	    case level
	        when 'notice' then "alert alert-dismissable alert-info"
	        when 'error' then "alert alert-dismissable alert-danger"
	        when 'alert' then "alert alert-dismissable alert-danger"

	       	when 'success' then "alert alert-dismissable alert-success"
	       	when 'warning' then "alert alert-dismissable alert-success"
	       	when 'info' then "alert alert-dismissable alert-success"
	    end
	end

end
