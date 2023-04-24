require 'rails_helper'

describe SalariesFacade do
  before :each do
    params = {destination: "chicago", controller: "api/v1/salaries", action: "city_salaries"}
    @facade = SalariesFacade.new(params)
  end

  it "can exist" do
    expect(@facade.destination).to eq("chicago")
  end

  it "can pull salary information by destination city" do
    VCR.use_cassette("salaries_chicago") do
      salaries = @facade.destination_salaries
    end

    expect(salaries).to be_a(Array)
    expect(salaries.first).to be_a(Salary)
  end
end