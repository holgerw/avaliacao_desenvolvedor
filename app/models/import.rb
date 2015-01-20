# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  saved_file :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  started    :boolean          default("f")
#  completed  :boolean          default("f")
#

require 'csv'

class Import < ActiveRecord::Base

  has_many :purchases, dependent: :destroy
  validates :saved_file, presence: true
  attr_accessor :file, :purchase_data

  #####################################
  # Public interface to be invoced from controller
  #####################################
  def perform_import!
    parse_file
    save_purchases
  end


  #####################################
  # Descrete steps of the business operation
  # Exposed publicly for testing reasons only
  #####################################
  def parse_file
    return nil unless File.file?(saved_file)
    self.purchase_data = CSV.read(saved_file, { :col_sep => "\t" })
    header = purchase_data.shift
    header.map! { |item| normalize_string(item).to_sym }
    purchase_data.map! do |row|
      row_hash = {}
      row.each_with_index do |item, index|
        row_hash[ header[index] ] = item
      end
      row_hash
    end
  end

  def save_purchases
    return if started # guarantee save_purchase is idempotent
    return if purchase_data.blank? # expect file parsing before persisting
    self.update_attribute(:started, true)
    begin
      purchase_data.each do | purchase |
        self.purchases.create!(purchase)
      end
      self.update_attribute(:completed, true)
    rescue
      # any failure during purchase persistence will
      # documentd by Import#completed = falses
    end
  end

  def normalize_string orig_string
    ascii_string = ActiveSupport::Inflector.transliterate( orig_string )
    ascii_string.downcase.gsub(' ', '_')
  end

end
