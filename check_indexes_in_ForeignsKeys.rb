#
# you are worry about forgeting indexes in your rails foreigns_key?
# no problem. this will help you.
# run it under your rails console
#

require 'pp'

def fn
	c = ActiveRecord::Base.connection
	c.tables.collect do |t| 
	  columns = c.columns(t).collect(&:name).select {|x| x.ends_with?("_id" || x.ends_with("_type"))}	  
	  indexed_columns = c.indexes(t).collect(&:columns).flatten.uniq
	  unindexed = columns - indexed_columns
	  unless unindexed.empty?
	    puts "#{t} Missing: #{unindexed.join(", ")}"
	  else
	  	puts "#{t} is Okay"
	  end
	end
end
