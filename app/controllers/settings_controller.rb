class SettingsController < ApplicationController
  include ResourceConcerns

  private

  def setting_params
    params.expect(setting: %i[variable value])
  end
end
