Fixjour do
  define_builder(Team) do |klass, overrides|
    klass.new(:name => 'Team', :division => new_division)
  end
end

