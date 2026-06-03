class Expense < ApplicationRecord
  has_many :payment_methods

  enum :status, {
    planned: 0,
    paid: 1,
    cancelled: 2
  }

  scope :paid_expenses, -> {
    where(status: :paid)
  }

  scope :planned_expenses, -> {
    where(status: :planned)
  }

  scope :large_expenses, -> {
    where("amount > ?", 5000)
  }

  scope :this_month, -> {
    where(
      date: Date.current.beginning_of_month..
      Date.current.end_of_month
    )
  }
end