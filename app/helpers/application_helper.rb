module ApplicationHelper
  def motd
    'Opening Ceremonies will be held at 2pm on Saturday, April 18th in the Middle School gym' if Time.now.utc < Chronic.parse('4/19/2015').utc
  end
end
