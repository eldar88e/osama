class ServicesController < ApplicationController
  include ResourceConcerns

  private

  def service_params
    params.expect(service: %i[title price duration_minutes category popularity active])
  end
end
