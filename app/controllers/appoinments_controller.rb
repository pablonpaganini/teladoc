class AppoinmentsController < ApplicationController

  def create(render = true)
    Date.strptime(params[:date], "%Y-%m-%d") rescue return render json: {"error": "Bad date"}, status: :bad_request

    appointment = Appointment.new
    appointment.doctor_id = params[:doctor_id]
    appointment.start_at = params[:start_at]
    appointment.ends_at = params[:ends_at]
    appointment.date = params[:date] 
    appointment.patient_id = params[:patient_id]

    unless appointment.valid?
      return render json: {"error": appointment.errors}, status: :bad_request if render
      return false
    end
    
    doctor = Doctor.find(appointment.doctor_id)
    unless doctor.is_available?(appointment.date, appointment.start_at, appointment.ends_at)
      return render json: {"error": "doctor is not available"}, status: :forbidden if render
      return false
    end
    
    if appointment.save!
      render json: {"msg": "appointment #{appointment.id} created"}, status: :ok if render
      return true
    else
      render json: {"error": appointment.errors}, status: :unprocessable_entity if render
      return false
    end
  end

  def delete(render = true)
    begin
      appointment = Appointment.find(params[:id])
      appointment.delete
      return render json: {"msg": "appointment #{params[:id]} deleted"}, status: :ok if render
    rescue ActiveRecord::RecordNotFound => e
      return render json: {"error": e}, status: :not_found if render
      return false
    rescue Exception => e
      return render json: {"error": e}, status: :unprocessable_entity if render
      return false
    end
    true
  end

  def update
    if self.create(false)
      self.delete(false)
      render json: {"msg": "appointment changed"}, status: :ok
    else
      render json: {"error": "cannot change appointment"}, status: :unprocessable_entity
    end
  end
end
