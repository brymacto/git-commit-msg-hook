require_relative '../commit-msg'

describe "commit message script" do
  it "Works" do
    opened_file = instance_double("File")
    test_commit_message = "Test commit message"
    allow(File).to receive(:open).and_return(opened_file)
    allow(opened_file).to receive(:read) { test_commit_message }

    result = run

    expect(result).to eq("Test commit message")
  end
end