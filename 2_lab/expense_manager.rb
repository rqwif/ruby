# Головний клас який керує усіма витратами
require 'json'
require 'yaml'
require_relative 'expense'

class ExpenseManager
  def initialize
    @collection = {}
  end

 

  def add_expense
    print "Назва: "
    title = gets.chomp

    print "Категорії: "
    categories = gets.chomp.split(',').map(&:strip)

    print "Оплата: "
    payment_methods = gets.chomp.split(',').map(&:strip)

    print "Сума: "
    amount = gets.chomp.to_f

    print "Дата: "
    date = gets.chomp

    print "Примітка: "
    notes = gets.chomp

    id = @collection.empty? ? 1 : @collection.keys.max + 1

    @collection[id] = Expense.new(
      title, categories, payment_methods,
      amount, date, notes
    )

    puts "Додано ID=#{id}"
  end

  def list_expenses
    @collection.each do |id, e|
      puts "\nID: #{id}"
      puts "Назва: #{e.title}"
      puts "Сума: #{e.amount}"
      puts "Статус: #{e.status}"
    end
  end

  def edit_expense
    print "ID: "
    id = gets.chomp.to_i

    expense = @collection[id]
    return puts "Не знайдено" unless expense

    print "Нова назва (#{expense.title}): "
    title = gets.chomp

    print "Нова сума: "
    amount = gets.chomp

    expense.title = title unless title.empty?
    expense.amount = amount.to_f unless amount.empty?

    puts "Оновлено"
  end

  def delete_expense
    print "ID: "
    id = gets.chomp.to_i

    if @collection.delete(id)
      puts "Видалено"
    else
      puts "Не знайдено"
    end
  end

  #Пошук
  def find_by_title
    print "Назва: "
    q = gets.chomp.downcase

    @collection.each do |id, e|
      if e.title.downcase.include?(q)
        puts "#{id}: #{e.title}"
      end
    end
  end

#Фільтри
  def filter_by_status
    print "Статус: "
    st = gets.chomp

    @collection.each do |id, e|
      puts "#{id}: #{e.title}" if e.status == st
    end
  end

  def filter_by_category
    print "Категорія: "
    cat = gets.chomp

    @collection.each do |id, e|
      puts "#{id}: #{e.title}" if e.categories.include?(cat)
    end
  end

  #Сума
  def total_amount
    sum = @collection.values.sum { |e| e.amount }
    puts "Загальна сума: #{sum}"
  end

  # JSON об'єкти перетворюються у hash
  def save_to_json(file)
    data = @collection.transform_values(&:to_h)
    File.write(file, JSON.pretty_generate(data))
    puts "JSON збережено"
  end

  def load_from_json(file)
  return unless File.exist?(file)

  data = JSON.parse(File.read(file)) 

  @collection = {}

  data.each do |id, hash|
    @collection[id.to_i] = Expense.from_h(
      hash.transform_keys(&:to_sym)
    )
  end

  puts "JSON завантажено"
end

  # YAML

  def save_to_yaml(file)
    data = @collection.transform_values(&:to_h)
    File.write(file, YAML.dump(data))
  end

  def load_from_yaml(file)
    data = YAML.load_file(file)

    result = {}

    data.each do |id, hash|
      result[id.to_i] = Expense.from_h(hash)
    end

    @collection = result
  end
end