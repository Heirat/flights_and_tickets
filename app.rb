# frozen_string_literal: true

require 'roda'
require_relative 'models'

# Main class
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:flights] = FlightList.new(InputCsv.read_flights)
  opts[:tickets] = TicketList.new(InputCsv.read_tickets)

  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/show_flights'
    end

    r.on 'add_flight' do
      r.get do
        view('add_flight')
      end

      r.post do
        @params = InputValidators.check_flight(r.params)
        if @params[:errors].empty?
          opts[:flights].add_flight(Flight.new(@params))
          r.redirect('/show_flights')
        else
          view('add_flight')
        end
      end
    end

    r.on 'del_flight' do
      r.get do
        view('del_flight')
      end

      r.post do
        @error = opts[:flights].find_del_flight(r.params)
        if @error.empty?
          r.redirect('/show_flights')
        else
          view('del_flight')
        end
      end
    end

    r.on('add_ticket') do
      r.get do
        view('add_ticket')
      end

      r.post do
        @params = InputValidators.check_ticket(r.params)
        if @params[:errors].empty?
          opts[:tickets].add_ticket(Ticket.new(@params))
          r.redirect('/show_tickets')
        else
          view('add_ticket')
        end
      end
    end

    r.on 'del_ticket' do
      r.get do
        view('del_ticket')
      end

      r.post do
        @error = opts[:tickets].find_del_ticket(r.params)
        if @error.empty?
          r.redirect('/show_tickets')
        else
          view('del_ticket')
        end
      end
    end

    r.on 'del_tickets' do
      r.get do
        view('del_tickets')
      end

      r.post do
        @error = opts[:tickets].find_del_tickets(r.params['depart_name'], r.params['dest_name'])
        if @error.empty?
          r.redirect('/show_tickets')
        else
          view('del_tickets')
        end
      end
    end

    r.on 'show_flights' do
      r.is do
        @params = InputValidators.check_filtered_flight(r.params['depart_name'],
                                                        r.params['dest_name'],
                                                        r.params['depart_date'])
        @filtered_flights = if @params[:errors].empty?
                              opts[:flights].filter(@params[:depart_name],
                                                    @params[:dest_name], @params[:depart_date])
                            else
                              opts[:flights].all
                            end
        view('show_flights')
      end
    end

    r.on 'show_tickets' do
      r.is do
        @params = InputValidators.check_filtered_ticket(r.params['depart_date'],
                                                        r.params['depart_time'])
        @filtered_tickets = if @params[:errors].empty?
                              opts[:tickets].filter(@params[:depart_date], @params[:depart_time])
                            else
                              opts[:tickets].all
                            end
        view('show_tickets')
      end
    end
  end
end
