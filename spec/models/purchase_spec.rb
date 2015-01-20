# == Schema Information
#
# Table name: purchases
#
#  id            :integer          not null, primary key
#  comprador     :string
#  descricao     :string
#  preco_uniario :decimal(16, 2)
#  quantidade    :integer
#  endereco      :string
#  fornecedor    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  import_id     :integer
#

require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
