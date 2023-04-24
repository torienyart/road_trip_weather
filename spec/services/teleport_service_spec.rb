require 'rails_helper'

describe TeleportService do
  it "returns a cities salaries in a hash" do
    VCR.use_cassette("forecast_denver") do
      @salaries = TeleportService.destination_salaries('denver')
    end

    expect(@salaries).to be_a(Hash)
    expect(@salaries[:salaries]).to be_a Array
    expect(@salaries[:salaries].first.keys).to include(:job, :salary_percentiles)
    expect(@salaries[:salaries].first[:job].keys).to include(:id, :title)
    expect(@salaries[:salaries].first[:salary_percentiles].keys).to include(:percentile_25, :percentile_50, :percentile_75)
  end
end