class ApartmentsController < ApplicationController  
  def index
    render json: Apartment.all, status: :ok
  end

  def create
    apartment = Apartment.create(apt_params)
    render json: apartment, status: :created
  end

  def update
    apt = Apartment.find_by(id: params[:id])
    if apt
      apt.update!(apt_params)
      render json: apt, status: :ok
    else
      render json: { error: "Apartment not found!" }, status: :not_found
    end
  end

  def destroy
    apt = Apartment.find_by(id: params[:id])
    if apt
      apt.destroy
      head :no_content
    else
      render json: { error: "Apartment not found!" }, status: :not_found
    end
  end

  private

  def apt_params
    params.permit(:number)
  end

end
