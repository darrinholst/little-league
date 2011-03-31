require 'csv'

desc "Import master list"
task :import => :environment do
  CSV.foreach("#{Rails.root}/lib/2010 master list.csv") do |row|
    birthdate = Chronic.parse(row[1])
    birthdate = birthdate.nil? ? nil : Chronic.parse("#{birthdate.month}/#{birthdate.day}/#{birthdate.year < 10 ? birthdate.year + 2000 : birthdate.year + 1900}")

    attributes = {
      :first_name => row[0].split.first,
      :last_name => row[0].split.second,
      :birthdate => birthdate,
      :parents => row[3],
      :phone_number => row[4],
      :alternate_phone_number => row[5],
      :shirt_size => row[6]
    }

    Player.create!(attributes)
  end
end
