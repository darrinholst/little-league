require 'csv'

module Admin
  class GameImport
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    include ActiveModel::Validations
    extend ActiveModel::Naming

    attr_accessor :division_id
    attr_accessor :csv

    validates :csv, presence: true
    validate :division_exists
    validate :division_not_scheduled
    validate :all_rows_are_valid

    def initialize(attributes = {})
      self.csv = attributes[:csv]
      self.division_id = attributes[:division_id]
    end

    def execute
      rows.each do |row|
        division = Division.find(division_id)

        Game.create!(
          starts_at: row.starts_at,
          visiting_team: division.teams.where(name: row.visiting_team).first_or_create,
          home_team: division.teams.where(name: row.home_team).first_or_create,
          field: Field.where(name: row.field).first_or_create
        )
      end
    end

    private

    class Row
      def initialize(columns)
        @columns = columns
      end

      def size
        @columns.size
      end

      def starts_at
        @columns[0].strip
      end

      def visiting_team
        @columns[1].strip
      end

      def home_team
        @columns[2].strip
      end

      def field
        @columns[3].strip
      end
    end

    def rows
      rows = []

      unless csv.blank?
        CSV.parse(csv.strip, {col_sep: "\t"}).each_with_index do |columns|
          rows << Row.new(columns) unless columns.empty?
        end
      end

      rows
    end

    def division_exists
      unless Division.exists?(division_id)
        errors.add :base, "Select a division"
        nil
      end
    end

    def division_not_scheduled
      if Division.exists?(division_id)
        division = Division.find(division_id)
        errors.add :base, "Games are already scheduled for #{division.name}. Delete them before importing." if Game.in_division(division.name).any?
        nil
      end
    end

    def all_rows_are_valid
      rows.each_with_index do |row, i|
        break if errors.any?
        errors.add :base, "Row #{i + 1} must have 4 columns, but it has #{row.size}" if row.size < 4
      end
    end

  end
end

