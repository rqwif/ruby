require_relative 'expense_manager'

app = ExpenseManager.new

# автозавантаження
if File.exist?("expenses.yml")
  app.load_from_yaml("expenses.yml")
elsif File.exist?("expenses.json")
  app.load_from_json("expenses.json")
end

loop do
  puts "\n===== МЕНЕДЖЕР ВИТРАТ ====="
  puts "1. Додати"
  puts "2. Показати"
  puts "3. Редагувати"
  puts "4. Видалити"
  puts "5. Пошук"
  puts "6. Фільтр статус"
  puts "7. Фільтр категорія"
  puts "8. Сума"
  puts "9. JSON save"
  puts "10. JSON load"
  puts "11. YAML save"
  puts "12. YAML load"
  puts "0. Вихід"

  print "Вибір: "
  choice = gets.chomp.to_i

  case choice
  when 1 then app.add_expense
  when 2 then app.list_expenses
  when 3 then app.edit_expense
  when 4 then app.delete_expense
  when 5 then app.find_by_title
  when 6 then app.filter_by_status
  when 7 then app.filter_by_category
  when 8 then app.total_amount
  when 9 then app.save_to_json("expenses.json")
  when 10 then app.load_from_json("expenses.json")
  when 11 then app.save_to_yaml("expenses.yml")
  when 12 then app.load_from_yaml("expenses.yml")

  when 0
    puts "Збереження..."
    app.save_to_yaml("expenses.yml")
    break

  else
    puts "Невірно"
  end
end