# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'httparty'
require 'csv'

responce = HTTParty.get("http://api.purdue.io/odata/Subjects")
for r in responce["value"]
    s = "http://api.purdue.io/odata/Courses?$filter=Subject/Abbreviation eq '"
    s << r["Abbreviation"]
    s << "'&$orderby=Number asc"
    s = URI.encode(s)
    s = URI.parse(s)
    c = HTTParty.get(s)
    for v in c["value"]
        if v["Number"][0] != ""
            number = v["Number"].to_i
            if number < 45000
                Course.create( "subject" => r["Abbreviation"], "course_Num" => v["Number"] )
            end
        end
    end
end

if Skill.count.zero?
    csv_text = File.read('SkillsList.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Skill.create!(row.to_hash)
    end
end
