# Описується один запис витрати
class Expense
  attr_accessor :title, :categories, :payment_methods, :amount, :date, :notes, :status
  
  # Створює нову витрату
  def initialize(title, categories, payment_methods, amount, date, notes, status = "planned")
    @title = title
    @categories = categories
    @payment_methods = payment_methods
    @amount = amount
    @date = date
    @notes = notes
    @status = status
  end

  # для JSON
  def to_h
    {
      title: @title,
      categories: @categories,
      payment_methods: @payment_methods,
      amount: @amount,
      date: @date,
      notes: @notes,
      status: @status
    }
  end

  # відновлення з JSON
  def self.from_h(hash)
    new(
      hash[:title],
      hash[:categories],
      hash[:payment_methods],
      hash[:amount],
      hash[:date],
      hash[:notes],
      hash[:status]
    )
  end
end