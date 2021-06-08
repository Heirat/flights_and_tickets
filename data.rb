# frozen_string_literal: true

require 'csv'
AIRPLANES_FILE = File.expand_path('data/flights.csv', __dir__)
TICKETS_FILE = File.expand_path('data/tickets.csv', __dir__)

list = []
nums = ['SU 1702', 'SU 1903', 'SU 1701', 'IB 7270']
names = %w[Москва Лондон Париж Екатеринбург Владивосток Нью-Йорк Киров]
dates = %w[2021-05-04 2021-05-05 2021-05-06 2021-05-07]
times = ['15:50', '16:14', '03:05', '00:50', '07:50', '05:30', '15:22']
planes = ['Airbus A319', 'Boeing 777-300', 'Boeing 777-400']
prices = [12_532, 14_324, 12_986, 22_637, 8674]
surnames = %w[Сидоров Иванов Петренко Исаев Никулин Карагин Дубровский Санин
              Меньшиков Филиппов]
p_names = %w[Николай Федор Иван Геннадий Артём Роман Евгений]

nums.each do |num|
  names.each do |depart_name|
    dates.each do |depart_date|
      times.each do |depart_time|
        names.each do |dest_name|
          dates.each do |dest_date|
            times.each do |dest_time|
              planes.each do |plane|
                prices.each do |price|
                  next if depart_name == dest_name
                  next if dest_date < depart_date
                  next if dest_date == depart_date && dest_time < depart_time

                  list << [num, depart_name, depart_date, depart_time, dest_name,
                           dest_date, dest_time, plane, price.to_i + rand(1000)]
                end
              end
            end
          end
        end
      end
    end
  end
end

if File.exist?(AIRPLANES_FILE)
  CSV.open(AIRPLANES_FILE, 'w') do |csv|
    list.sample(3000).each do |el|
      csv << el
    end
  end
else
  pp 1
end

ticket_list = []
i = 0

names.each do |depart_name|
  dates.each do |depart_date|
    times.each do |depart_time|
      names.each do |dest_name|
        surnames.each do |surname|
          p_names.each do |name|
            next if depart_name == dest_name

            ticket_list << [0, depart_name, depart_date, depart_time, dest_name,
                            surname, name]
          end
        end
      end
    end
  end
end

if File.exist?(TICKETS_FILE)
  CSV.open(TICKETS_FILE, 'w') do |csv|
    ticket_list.sample(3000).each do |el|
      i += 1
      csv << [i, el[1], el[2], el[3], el[4], el[5], el[6]]
    end
  end
else
  pp 2
end
