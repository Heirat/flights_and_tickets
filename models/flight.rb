# frozen_string_literal: true

# Flight class
class Flight
  attr_reader :num, :depart_name, :depart_date, :depart_time, :dest_name, :dest_date,
              :dest_time, :plane, :price

  def initialize(params)
    @num = params[:num]
    @depart_name = params[:depart_name]
    @depart_date = params[:depart_date]
    @depart_time = params[:depart_time]
    @dest_name = params[:dest_name]
    @dest_date = params[:dest_date]
    @dest_time = params[:dest_time]
    @plane = params[:plane]
    @price = params[:price]
  end
end
