# frozen_string_literal: true

require_relative 'input_checks'

# Validates Input
module InputValidators
  def self.check_filtered_flight(raw_depart_name, raw_dest_name, raw_depart_date)
    depart_name = (raw_depart_name || '').strip
    dest_name = (raw_dest_name || '').strip
    depart_date = (raw_depart_date || '').strip
    errors = []
    errors = [].concat(check_date_format(depart_date)) unless depart_date.empty?

    {
      depart_name: depart_name,
      dest_name: dest_name,
      depart_date: depart_date,
      errors: errors
    }
  end

  def self.check_filtered_ticket(raw_depart_date, raw_depart_time)
    depart_date = (raw_depart_date || '').strip
    depart_time = (raw_depart_time || '').strip
    errors = []
    errors = [].concat(InputChecks.check_date_format(depart_date)) unless depart_date.empty?
    errors.concat(InputChecks.check_time_format(depart_time)) unless depart_time.empty?

    {
      depart_date: depart_date,
      depart_time: depart_time,
      errors: errors
    }
  end

  def self.prepare(value)
    (value || '').strip
  end

  def self.flight_collect_errors(params)
    [].concat(InputChecks.check_num(params['num']))
      .concat(InputChecks.check_depart_name(params['depart_name']))
      .concat(InputChecks.check_depart_date(params['depart_date']))
      .concat(InputChecks.check_date_format(params['depart_date']))
      .concat(InputChecks.check_depart_time(params['depart_time']))
      .concat(InputChecks.check_dest_name(params['dest_name']))
      .concat(InputChecks.check_dest_date(params['dest_date']))
      .concat(InputChecks.check_date_format(params['dest_date']))
      .concat(InputChecks.check_dest_time(params['dest_time']))
      .concat(InputChecks.check_plane(params['plane']))
      .concat(InputChecks.check_price(params['price']))
      .concat(InputChecks.check_date_time(params['dest_date'],
                                          params['depart_date'],
                                          params['dest_time'],
                                          params['depart_time']))
  end

  def self.check_flight(params)
    {
      num: prepare(params['num']),
      depart_name: prepare(params['depart_name']),
      depart_date: prepare(params['depart_date']),
      depart_time: prepare(params['depart_time']),
      dest_name: prepare(params['dest_name']),
      dest_date: prepare(params['dest_date']),
      dest_time: prepare(params['dest_time']),
      plane: prepare(params['plane']),
      price: prepare(params['price']),
      errors: flight_collect_errors(params)
    }
  end

  def self.ticket_collect_errors(params)
    [].concat(InputChecks.check_depart_name(params['depart_name']))
      .concat(InputChecks.check_depart_date(params['depart_date']))
      .concat(InputChecks.check_date_format(params['depart_date']))
      .concat(InputChecks.check_depart_time(params['depart_time']))
      .concat(InputChecks.check_dest_name(params['dest_name']))
      .concat(InputChecks.check_surname(params['surname']))
      .concat(InputChecks.check_name(params['name']))
  end

  def self.check_ticket(params)
    {
      depart_name: prepare(params['depart_name']),
      depart_date: prepare(params['depart_date']),
      depart_time: prepare(params['depart_time']),
      dest_name: prepare(params['dest_name']),
      surname: prepare(params['surname']),
      name: prepare(params['name']),
      errors: ticket_collect_errors(params)
    }
  end
end
