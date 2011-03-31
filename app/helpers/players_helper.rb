module PlayersHelper
  def format_birthdate(date)
    date.nil? ? "" : date.strftime("%m/%d/%Y")
  end
end
