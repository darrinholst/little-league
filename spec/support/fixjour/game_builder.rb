Fixjour do
  define_builder(Game) do |klass, overrides|
    klass.new(:visiting_team => new_team, :home_team => new_team)
  end
end
