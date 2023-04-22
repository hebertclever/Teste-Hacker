class ReportController < ApplicationController
  def update
    report = Report.find(params[:id])
    if report.update(report_params)
      render json: report, status: 200
    else
      render json: report.errors, status: 422
    end
  end

  private

  def report_params
    params.permit(:date, :name, :gender, :age, :city, :state, :county, :latitude, :longitude)
  end
end
