# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
	assert page.body =~ /#{e1}.+#{e2}/m
	
#	x = page.body.split(e1)
#  assert x.length == 3 # 3 partes: antes de e1, e1, despues de e1
#  x = x[2].split(e2)
#  assert x.length == 3
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{\s*,\s*}).each_with_index{
  	|rate, index|
  		if(index) #demas elementos
				step %{I #{uncheck}check "ratings[#{rate}]"}  
			else
				step %{I #{uncheck}check "ratings[#{rate}]"}  
			end
  }  
end

#Then /I should( not)? see all of the movies: (.*)/ do |ifnot, movies_list|
Then /I should( not)? see all of the movies/ do |orNot|

#	Movie.all.each_with_index {
 #   |movie, index|
  #    name = movie[:title]
   #   if(!index) #first element
    #    step %{I should#{orNot} see "#{name}"}
     # else
      #  step %{I should#{orNot} see "#{name}"}
#      end
#  }
	
  rows = page.all('#movies tr').size - 1
  if (orNot)  #not all the movies
  	rows == 0
	else #all the movies
		rows == Movie.count()
	end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  m = Movie.find_by_title(title)
  assert director == m.director
end
