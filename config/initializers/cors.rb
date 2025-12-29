Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('FRONTEND_HOST', 'http://localhost:3000')

    resource '/api/v1/*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: [:Authorization]
  end
end
