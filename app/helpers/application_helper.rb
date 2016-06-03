module ApplicationHelper
  def motd
    'Closing Ceremonies will be held at 2pm on Sunday, June 12th at the Majors Field' if Time.now.utc < Chronic.parse('6/12/2016 4pm').utc
  end
end
