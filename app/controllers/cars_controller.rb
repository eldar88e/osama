class CarsController < ApplicationController
  include ResourceConcerns

  private

  def car_params
    params.expect(car: %i[user_id brand model license_plate vin comment])
  end
end
