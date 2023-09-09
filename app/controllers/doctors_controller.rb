class DoctorsController < ApplicationController

  def index
    doctors = Doctor.select(:id, :name).includes(:working_days)
    render json:  doctors, include: {working_days: {only: [:day, :start_at, :ends_at]}}, status: :ok
  end

  def available_time
    begin
      Date.strptime(params[:date], "%Y-%m-%d") rescue return render json: {"error": "Bad date"}, status: :bad_request
      doctor = Doctor.find(params[:id])  
      render json: {date: params[:date], available_slots: doctor.available_slots(params[:date])}, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {"error": e}, status: :not_found
    rescue Exception => e
      render json: {"error": e}, status: :unprocessable_entity
    end
  end
end

