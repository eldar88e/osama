module Api
  module ResourceConcern
    extend ActiveSupport::Concern
    include Pundit::Authorization

    included do
      before_action :set_resource, only: %i[show update destroy]
      before_action :authorize_resource!
    end

    def index
      q = policy_scope(resource_class).order(:created_at).ransack(params[:q])

      pagy, resources = pagy(q.result)

      render json: { data: serializer.new(resources), meta: pagy_metadata(pagy) }
    end

    def show
      render json: serializer.new(@resource)
    end

    def create
      @resource = resource_class.new(resource_params)

      if @resource.save
        render json: serializer.new(@resource), status: :created
      else
        error_response
      end
    end

    def update
      if @resource.update(resource_params)
        render json: serializer.new(@resource)
      else
        error_response
      end
    end

    def destroy
      @resource.destroy!
      head :no_content
    end

    private

    def resource_params
      send "#{resource_class.model_name.param_key}_params"
    end

    def set_resource
      @resource = resource_class.find(params[:id])
    end

    def authorize_resource!
      authorize @resource || resource_class
    end

    def resource_class
      controller_name.classify.constantize
    end

    def serializer
      "#{resource_class}Serializer".constantize
    end

    def error_response
      render json: { errors: 'ar', message: @resource.errors.full_messages.join(', ') }, status: :unprocessable_content
    end
  end
end
