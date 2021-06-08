# frozen_string_literal: true

require_relative 'ticket'

# List of tickets
class TicketList
  def initialize(tickets = [])
    @tickets = tickets
    @last_id = tickets.map(&:id).max
  end

  def all
    @tickets.sort_by { |ticket| [ticket.id] }
  end

  attr_reader :last_id

  def add_ticket(ticket)
    @last_id += 1
    ticket.id = @last_id
    @tickets.append(ticket)
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

  def check_ticket(ticket, params)
    check(params['id'].strip, ticket.id) &&
      check(params['depart_name'].strip, ticket.depart_name) &&
      check(params['depart_date'].strip, ticket.depart_date) &&
      check(params['depart_time'].strip, ticket.depart_time) &&
      check(params['dest_name'].strip, ticket.dest_name) &&
      check(params['surname'].strip, ticket.surname) &&
      check(params['name'].strip, ticket.name)
  end

  def find_del_ticket(params)
    # id, depart_name, depart_date, depart_time, dest_name, surname, name
    tickets = @tickets.select do |ticket|
      check_ticket(ticket, params)
    end

    if tickets.empty?
      'Не найдено элементов для удаления'
    elsif tickets.length > 1
      'Найдено больше 1 элемента'
    else
      @tickets.delete(tickets.first)
      ''
    end
  end

  def find_del_tickets(depart_name, dest_name)
    del_tickets = @tickets.select do |ticket|
      check(depart_name, ticket.depart_name) &&
        check(dest_name, ticket.dest_name)
    end

    if del_tickets.empty?
      'Не найдено элементов для удаления'
    else
      del_tickets.each do |ticket|
        @tickets.delete(ticket)
      end
      ''
    end
  end

  def filter(depart_date, depart_time)
    @tickets.select do |ticket|
      check(depart_date, ticket.depart_date) &&
        check(depart_time, ticket.depart_time)
    end.sort_by(&:id)
  end
end
