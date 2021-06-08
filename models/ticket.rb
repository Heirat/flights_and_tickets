# frozen_string_literal: true

# Ticket class
class Ticket
  attr_reader :depart_name, :depart_date, :depart_time, :dest_name, :surname, :name
  attr_accessor :id

  def initialize(params)
    @id = params[:id]
    @depart_name = params[:depart_name]
    @depart_date = params[:depart_date]
    @depart_time = params[:depart_time]
    @dest_name = params[:dest_name]
    @surname = params[:surname]
    @name = params[:name]
  end
end
