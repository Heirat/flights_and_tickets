# frozen_string_literal: true

require_relative 'flight'

# List of flights
class FlightList
  def initialize(flights = [])
    @flights = flights
  end

  def all
    @flights.sort_by { |flight| [flight.depart_date, flight.depart_time] }
  end

  def add_flight(flight)
    @flights.append(flight)
  end

  def check(input, value)
    num_inp = begin
      Integer(input)
    rescue StandardError
      false
    end
    if num_inp
      num_inp == value.to_i
    else
      input.empty? || input == value
    end
  end

  def check_flight(flight, params)
    check(params['num'].strip, flight.num) &&
      check(params['depart_name'].strip, flight.depart_name) &&
      check(params['depart_date'].strip, flight.depart_date) &&
      check(params['depart_time'].strip, flight.depart_time) &&
      check(params['dest_name'].strip, flight.dest_name) &&
      check(params['dest_date'].strip, flight.dest_date) &&
      check(params['dest_time'].strip, flight.dest_time) &&
      check(params['plane'].strip, flight.plane) &&
      check(params['price'].strip, flight.price)
  end

  def find_del_flight(params)
    flights = @flights.select do |flight|
      check_flight(flight, params)
    end

    if flights.empty?
      'Не найдено элементов для удаления'
    elsif flights.length > 1
      'Найдено больше 1 элемента'
    else
      @flights.delete(flights.first)
      ''
    end
  end

  def filter(depart_name, dest_name, depart_date)
    selected_flights = @flights.select do |flight|
      check(depart_name, flight.depart_name) &&
        check(dest_name, flight.dest_name) &&
        check(depart_date, flight.depart_date)
    end
    selected_flights.sort_by do |flight|
      [flight.depart_date, flight.depart_time]
    end
  end
end
