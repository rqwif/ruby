module ExpensesHelper
  def amount_badge(expense)
    amount = expense.amount

    css_class =
      if amount < 500
        "badge bg-success"
      elsif amount < 5000
        "badge bg-warning"
      else
        "badge bg-danger"
      end

    content_tag(:span,
                format('%.2f грн', amount),
                class: css_class)
  end
end