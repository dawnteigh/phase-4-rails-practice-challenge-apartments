class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def index
    render json: Tenant.all, status: :ok
  end

  def create
    tenant = Tenant.create!(t_params)
    render json: tenant, status: :created
  end

  def update
    tenant = Tenant.find_by(id: params[:id])
    if tenant
      tenant.update!(t_params)
      render json: tenant, status: :ok
    else
      render json: { error: "Tenant not found!" }, status: :not_found
    end
  end

  def destroy
    tenant = Tenant.find_by(id: params[:id])
    if tenant
      tenant.destroy
      head :no_content
    else
      render json: { error: "Tenant not found!" }, status: :not_found
    end
  end

  private

  def t_params
    params.permit(:name, :age)
  end

  def invalid(invalid)
    render json: {error: invalid.record.errors.full_messages }, status: 422
  end

end
