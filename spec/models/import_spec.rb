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

require 'rails_helper'

RSpec.describe Import, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
