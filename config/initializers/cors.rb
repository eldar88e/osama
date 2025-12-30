ORIGINS = ENV.fetch('FRONTEND_HOST', 'http://localhost:3000').split(',').map(&:strip)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*ORIGINS)

    resource '/api/v1/*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             max_age: 86_400
  end
end
