require 'spec_helper'
require './features/step_definitions/testing_dsl'

describe "Manually Assigned Licenses" do
  # As a developer
  # I want to be able to manually set licenses
  # So that my dependencies all have the correct licenses

  let(:user) { LicenseFinder::TestingDSL::User.new }

  specify "are shown in reports" do
    user.create_ruby_app
    user.create_and_depend_on_gem 'mislicensed_dep', license: 'Unknown'
    user.execute_command 'license_finder licenses add mislicensed_dep Known'

    user.run_license_finder
    expect(user).not_to be_seeing_something_like /mislicensed_dep.*Unknown/
    expect(user).to be_seeing_something_like /mislicensed_dep.*Known/
  end
end