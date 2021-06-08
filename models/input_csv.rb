# frozen_string_literal: true

require 'csv'
require_relative 'flight'
require_relative 'ticket'

# Reads data from csv file
module InputCsv
  FLIGHTS_FILE = File.expand_path('../data/flights.csv', __dir__)
  TICKETS_FILE = File.expand_path('../data/tickets.csv', __dir__)

  def self.read_flights
    list = []
    if File.exist?(FLIGHTS_FILE)
      CSV.foreach(FLIGHTS_FILE) do |row|
        list.append(Flight.new({
                                 num: row[0],
                                 depart_name: row[1],
                                 depart_date: row[2],
                                 depart_time: row[3],
                                 dest_name: row[4],
                                 dest_date: row[5],
                                 dest_time: row[6],
                                 plane: row[7],
                                 price: row[8].to_i
                               }))
      end
    end
    list
  end

  def self.read_tickets
    list = []
    if File.exist?(TICKETS_FILE)
      CSV.foreach(TICKETS_FILE) do |row|
        list.append(Ticket.new({
                                 id: row[0].to_i,
                                 depart_name: row[1],
                                 depart_date: row[2],
                                 depart_time: row[3],
                                 dest_name: row[4],
                                 surname: row[5],
                                 name: row[6]
                               }))
      end
    end
    list
  end
end
