class ReportsController < ApplicationController
  def index
    reports = Report.all

    # Filtragem por data
    if params[:date_from].present?
      reports = reports.where("date >= ?", params[:date_from])
    end

    if params[:date_to].present?
      reports = reports.where("date <= ?", params[:date_to])
    end

    # Filtragem por idade
    if params[:age_from].present?
      reports = reports.where("age >= ?", params[:age_from])
    end

    if params[:age_to].present?
      reports = reports.where("age <= ?", params[:age_to])
    end

    # Filtragem por gênero
    if params[:gender].present?
      reports = reports.where(gender: params[:gender])
    end

    # Filtragem por distância
    if params[:latitude].present? && params[:longitude].present? && params[:distance].present?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      distance = params[:distance].to_f

      reports = reports.select do |report|
        coordinates_distance(latitude, longitude, report.latitude, report.longitude) <= distance
      end
    end

    # Ordenação
    reports = reports.order(:id)

    # Renderização do JSON
    render json: reports
  end
end
