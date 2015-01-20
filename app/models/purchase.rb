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

class Purchase < ActiveRecord::Base
  belongs_to :import

  def total_despense
    preco_uniario * quantidade
  end
end
