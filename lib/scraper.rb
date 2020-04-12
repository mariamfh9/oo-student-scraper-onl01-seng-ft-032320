require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  
  def self.scrape_index_page(index_url)
    
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student|
      profile = {}
      profile[:name] = student.css("h4.student-name").text
      profile[:location] = student.css("p.student-location").text
      profile[:profile_url] =  student.css("a").attribute("href").value
      students << profile
          #binding.pry
    end
    students
    
  end
  
def self.scrape_profile_page(profile_url)
  attributes_hash = {}
  html = open(profile_url)
  profile = Nokogiri::HTML(html)
   #binding.pry
  profile.css("main-wrapper.profile.social-icon-container a").each do |student|
    
    if student.attribute("href").value.include?("twitter.com")
      attributes_hash[:twitter] = student.attribute("href").value
     
    elsif student.attribute("href").value.include?("linkedin.com")
      attributes_hash[:linkedin] = student.attribute("href").value
    
    elsif student.attribute("href").value.include?("github.com")
      attributes_hash[:github] = student.attribute("href").value 
      
    else 
      attributes_hash[:blog] = student.attribute("href").value
    end 
    
    attributes_hash[:profile_quote] = profile.css("div.main-wrapper.profile.vitals-text-container .profile-quote").text
    attributes_hash[:bio] = profile.css("div.main-wrapper.profile.description-holder p").text
     
   end

   

    attributes_hash

   
    
  end 
 



end

