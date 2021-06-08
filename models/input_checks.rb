# frozen_string_literal: true

# Checks for fields
module InputChecks
  def self.check_num(num)
    if num.empty?
      ['Номер рейса не может быть пустым']
    else
      []
    end
  end

  def self.check_depart_name(depart_name)
    if depart_name.empty?
      ['Пункт отправления не может быть пустым']
    else
      []
    end
  end

  def self.check_depart_time(depart_time)
    if depart_time.empty?
      ['Время вылета не может быть пустым']
    else
      []
    end
  end

  def self.check_dest_name(dest_name)
    if dest_name.empty?
      ['Пункт назначения не может быть пустым']
    else
      []
    end
  end

  def self.check_dest_date(dest_date)
    if dest_date.empty?
      ['Дата прибытия не может быть пустой']
    else
      []
    end
  end

  def self.check_depart_date(depart_date)
    if depart_date.empty?
      ['Дата вылета не может быть пустой']
    else
      []
    end
  end

  def self.check_date_time(dest_date, depart_date, dest_time, depart_time)
    if dest_date < depart_date
      ['Дата прибытия не может быть меньше даты вылета']
    elsif depart_date == dest_date && dest_time < depart_time
      ['Время прибытия не может быть меньше времени вылета в течение одних суток']
    else
      []
    end
  end

  def self.check_dest_time(dest_time)
    if dest_time.empty?
      ['Время прибытия не может быть пустым']
    else
      []
    end
  end

  def self.check_plane(plane)
    if plane.empty?
      ['Тип самолета не может быть пустым']
    else
      []
    end
  end

  def self.check_price(price)
    num = begin
      Integer(price)
    rescue StandardError
      false
    end
    if price.empty?
      ['Стоимость не может быть пустой']
    elsif !num || num <= 0
      ['Стоимость должна быть натуральным числом']
    else
      []
    end
  end

  def self.check_surname(surname)
    if surname.empty?
      ['Фамилия пассажира не может быть пустой']
    else
      []
    end
  end

  def self.check_name(name)
    if name.empty?
      ['Имя пассажира не может быть пустым']
    else
      []
    end
  end

  def self.check_date_format(date)
    if /(19|20)\d\d-((0[1-9]|1[012])-(0[1-9]|[12]\d)|(0[13-9]|1[012])-30|(0[13578]|1[02])-31)/ =~ date
      []
    else
      ['Дата должна быть в формате ГГГГ-ММ-ДД']
    end
  end

  def self.check_time_format(time)
    if /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/ =~ time
      []
    else
      ['Время должно быть в формате ЧЧ:ММ']
    end
  end
end
