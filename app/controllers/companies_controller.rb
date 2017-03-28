class CompaniesController < ApplicationController
  def index
    relation = Company.page(params[:page])
    render json: { collection: relation, pagination: {
        total: relation.total_pages,
        current: relation.current_page
    }}
  end

  def create
    company = Company.new resource_params
    if company.save
      render json: company.to_json
    else
      render json: { errors: company.errors.messages }, status: 406
    end
  end

  def generate
    count = params[:count]
    render json: { errors: ['count parameter is blank'] }, status: 406 if count.nil?

    companies_attributes = (1..count.to_i).to_a.map do
      { name: "#{Faker::Company.name} (#{Faker::Company.ein})" }
    end
    Company.create(companies_attributes)
  end

  private

  def resource_params
    params.permit(:name)
  end
end
