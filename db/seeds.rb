Time.zone = ActiveSupport::TimeZone["America/Chicago"]
Chronic.time_class = Time.zone
Dir["db/seeds/**/*.rb"].each {|f| load f}

