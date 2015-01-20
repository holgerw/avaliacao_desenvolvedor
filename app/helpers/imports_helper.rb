module ImportsHelper

  def creation_date(import)
    import.created_at.strftime('%d/%m/%Y - %H:%M')
  end

  def size(import)
    import.purchases.count
  end
end
