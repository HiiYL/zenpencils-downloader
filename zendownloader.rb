require 'mechanize'
require 'colorize'
agent = Mechanize.new
page = agent.get("http://zenpencils.com")
options = page.parser.css("select option")
page.parser.css("select option").each do |link|
  title = link.children.text
  puts "Now Downloading: " + title
  curr_page = agent.get link.attributes['value'].text
  curr_page.parser.xpath('//*[@id="comic"]/img').each do |comic|
    img_name = comic.attributes["src"].text.split("/").last
    if Dir[title + "/" + img_name].empty?
      agent.get(comic.attributes["src"]).save title + "/" + img_name
      puts "create ".green + img_name
    else
      puts "identical ".blue + img_name
    end
  end
end
