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

  it 'parses the tab seperated file' do
    ########################################
    # Setup test data and clean environment
    ########################################
    file_path = "/tmp/#{SecureRandom.uuid}.txt"
     File.open(file_path, 'w') do |file|
      file.puts "comprador\tdescrição\tPreço Uniário\tQuantidade\tEndereço\tFornecedor"
      file.puts "João Silva\tR$10 off R$20 of food\t10.0\t2\t987 Fake St\tBob's Pizza"
      file.puts "Amy Pond\tR$30 of awesome for R$10\t10.0\t5\t456 Unreal Rd\tTom's Awesome Shop"
    end

    ########################################
    # Perform operation
    ########################################
    import = Import.new(saved_file: file_path)
    import.parse_file

    ########################################
    # Assert
    ########################################
    expect(import.purchase_data.size).to eq 2
    expect(import.purchase_data[0]).to eq( { comprador: 'João Silva',
                                            descricao: 'R$10 off R$20 of food',
                                            preco_uniario: '10.0',
                                            quantidade: '2',
                                            endereco: '987 Fake St',
                                            fornecedor: "Bob's Pizza" } )
    expect(import.purchase_data[1]).to eq( { comprador: 'Amy Pond',
                                            descricao: 'R$30 of awesome for R$10',
                                            preco_uniario: '10.0',
                                            quantidade: '5',
                                            endereco: '456 Unreal Rd',
                                            fornecedor: "Tom's Awesome Shop" } )
  end

  it 'persists every purchase parsed' do
    ########################################
    # Setup test data and clean environment
    ########################################
    parsed = []
    parsed << { comprador: 'João Silva',
                descricao: 'R$10 off R$20 of food',
                preco_uniario: '10.0',
                quantidade: '2',
                endereco: '987 Fake St',
                fornecedor: "Bob's Pizza" }
    parsed << { comprador: 'Amy Pond',
                descricao: 'R$30 of awesome for R$10',
                preco_uniario: '10.0',
                quantidade: '5',
                endereco: '456 Unreal Rd',
                fornecedor: "Tom's Awesome Shop" }
    Import.delete_all
    Purchase.delete_all
    import = Import.create
    import.purchase_data = parsed

    ########################################
    # Perform operation
    ########################################
    import.save_purchases

    ########################################
    # Assert
    ########################################
    expect(Purchase.where(comprador: 'João Silva').count).to eq 1
    expect(Purchase.where(comprador: 'Amy Pond').count).to eq 1
  end

end
