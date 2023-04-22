class ReportController < ApplicationController
  def create
    report = Report.new(report_params)

    if report.save
      render json: report, status: 201
    else
      render json: report.errors, status: 422
    end
  end

  private

  def report_params
    params.permit(:date, :name, :gender, :age, :city, :state, :county, :latitude, :longitude)
  end
end
