require "nokogiri"
require "pry"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta li a")
  # the location they got was below - find out difference
  # location: project.css("ul.project-meta span.location-name").text

  # percent_funded: project.css("ul.project-stats li.first.funded strong").text


  projects = {}

  # iterating through the projects: ^ above
  kickstarter.css("li.project.grid_4").each do |project|
  	title = project.css("h2.bbcard_name strong a").text
  	projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    
  	}

  	# projects[project] = {}
  	# ^cant just do this because it wont have "clean" keys, keys will be large and messy like objects
  end

	# returns project hash
	projects
end


create_project_hash