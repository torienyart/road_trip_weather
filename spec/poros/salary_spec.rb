require 'rails_helper'

describe Salary do
  it "can create a new instance of Salary" do
    salary_info = {:job=>{:id=>"ACCOUNT-MANAGER", :title=>"Account Manager"},
    :salary_percentiles=>
     {:percentile_25=>53732.4997858553,
      :percentile_50=>67273.75507905365,
      :percentile_75=>84227.57438186172}}

    salary = Salary.new(salary_info)

    expect(salary).to be_instance_of Salary
    expect(salary.title).to eq("Account Manager")
    expect(salary.min).to eq("$53,732.50")
    expect(salary.max).to eq("$84,227.57")
  end
end