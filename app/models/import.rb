# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  saved_file :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Import < ActiveRecord::Base

  # non persistent attribute
  attr_accessor :file

end
