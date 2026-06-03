require 'json'
require 'yaml'

# Додавання нового запису
def add_expense(collection, title:, categories:, payment_methods:, amount:, date:, notes:, status:)
  new_id = collection.keys.max.to_i + 1

  collection[new_id] = {
    title: title,
    categories: categories,
    payment_methods: payment_methods,
    amount: amount,
    date: date,
    notes: notes,
    status: status
  }

  puts "Витрату додано. ID: #{new_id}"
end

# Редагування запису
def edit_expense(collection, id, new_data)
  if collection.key?(id)
    collection[id].merge!(new_data)
    puts "Витрату #{id} оновлено."
  else
    puts "Помилка: запис не знайдено."
  end
end

# Видалення запису
def delete_expense(collection, id)
  if collection.delete(id)
    puts "Витрату #{id} видалено."
  else
    puts "Помилка: запис не знайдено."
  end
end

# Виведення всіх записів
def list_expenses(collection)
  if collection.empty?
    puts "Список витрат порожній."
    return
  end

  collection.each do |id, expense|
    puts "\nID: #{id}"
    puts "Назва: #{expense[:title]}"
    puts "Категорії: #{expense[:categories].join(', ')}"
    puts "Спосіб оплати: #{expense[:payment_methods].join(', ')}"
    puts "Сума: #{expense[:amount]}"
    puts "Дата: #{expense[:date]}"
    puts "Примітки: #{expense[:notes]}"
    puts "Статус: #{expense[:status]}"
  end
end

# Пошук за назвою
def find_by_title(collection, query)
  collection.select do |_, expense|
    expense[:title].downcase.include?(query.downcase)
  end
end

# Фільтрація за категорією
def filter_by_category(collection, category)
  collection.select do |_, expense|
    expense[:categories].any? do |c|
      c.downcase == category.downcase
    end
  end
end

# Фільтрація за статусом
def filter_by_status(collection, status)
  collection.select do |_, expense|
    expense[:status].downcase == status.downcase
  end
end

# Загальна сума витрат
def total_amount(collection)
  collection.values.sum { |expense| expense[:amount] }
end

# Збереження у JSON
def save_to_json(collection, filename)
  File.write(filename, JSON.pretty_generate(collection))
  puts "Дані збережено у #{filename}"
end

# Завантаження з JSON
def load_from_json(filename)
  data = JSON.parse(File.read(filename), symbolize_names: true)

  result = {}
  data.each do |id, expense|
    result[id.to_i] = expense
  end

  result

rescue Errno::ENOENT
  puts "Файл #{filename} не знайдено."
  {}
end

# Збереження у YAML
def save_to_yaml(collection, filename)
  File.write(filename, collection.to_yaml)
  puts "Дані збережено у #{filename}"
end

# Завантаження з YAML
def load_from_yaml(filename)
  YAML.load_file(filename)

rescue Errno::ENOENT
  puts "Файл #{filename} не знайдено."
  {}
end

# Початкові дані
expenses = {
  1 => {
    title: "Продукти",
    categories: ["Їжа", "Побут"],
    payment_methods: ["Готівка", "Картка"],
    amount: 450.50,
    date: "2024-03-01",
    notes: "Покупка в супермаркеті",
    status: "paid"
  },
  2 => {
    title: "Оренда офісу",
    categories: ["Бізнес"],
    payment_methods: ["Картка"],
    amount: 15000.00,
    date: "2024-03-05",
    notes: "Щомісячна оплата",
    status: "planned"
  }
}

# Приклади використання

list_expenses(expenses)

add_expense(
  expenses,
  title: "Інтернет",
  categories: ["Комунальні послуги"],
  payment_methods: ["Картка"],
  amount: 300,
  date: "2024-03-10",
  notes: "Оплата провайдера",
  status: "paid"
)

puts "\nПошук за назвою:"
p find_by_title(expenses, "Продукти")

puts "\nФільтр за категорією:"
p filter_by_category(expenses, "Бізнес")

puts "\nФільтр за статусом:"
p filter_by_status(expenses, "paid")

puts "\nЗагальна сума витрат:"
puts total_amount(expenses)

save_to_json(expenses, "expenses.json")
save_to_yaml(expenses, "expenses.yaml")