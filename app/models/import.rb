# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  saved_file :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'csv'

class Import < ActiveRecord::Base
  # non persistent attributes
  attr_accessor :file, :import_data
  # validations
  validates :saved_file, presence: true

  def parse_file
    return nil unless File.file?(saved_file)
    self.import_data = CSV.read(saved_file, { :col_sep => "\t" })
    header = import_data.shift
    header.map! { |item| Import.normalize_string(item).to_sym }
    import_data.map! do |row|
      row_hash = {}
      row.each_with_index do |item, index|
        row_hash[ header[index] ] = item
      end
      row_hash
    end
  end

  # auxiliar methods (public for testing purpose)
  def self.normalize_string orig_string
    ascii_string = ActiveSupport::Inflector.transliterate( orig_string )
    ascii_string.downcase.gsub(' ', '_')
  end

end
