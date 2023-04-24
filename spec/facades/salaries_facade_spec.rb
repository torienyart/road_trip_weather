require 'rails_helper'

describe SalariesFacade do
  before :each do
    params = {"destination"=>"chicago", "controller"=>"api/v1/salaries", "action"=>"city_salaries"}
    facade = SalariesFacade.new(params)
  end

  it "can exist" do
    expect(facade.destination).to eq("chicago")
  end

  it "can pull salary information by destination city" do
    expect(facade.destination_salaries).to be_a(Array)
    expect(facade.destination_salaries.first).to be_a(Salary)
  end
end