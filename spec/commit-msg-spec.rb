require_relative '../commit-msg'

describe "commit message script" do
  it "Aborts if commit message does not contain branch number" do
    test_commit_message = "Test commit message"
    test_branch_name = "9999_"
    opened_file = instance_double("File")
    allow(File).to receive(:open).and_return(opened_file)
    allow(self).to receive(:branch_name).and_return(test_branch_name)
    allow(opened_file).to receive(:read) { test_commit_message }

    begin
      run
    rescue SystemExit=>e
      assert_exit_aborts_commit(e)
    end
  end

  it "Does not abort if commit message contains branch number" do
    test_commit_message = "#9999 - Test commit message"
    test_branch_name = "9999_"
    opened_file = instance_double("File")
    allow(File).to receive(:open).and_return(opened_file)
    allow(self).to receive(:branch_name).and_return(test_branch_name)
    allow(opened_file).to receive(:read) { test_commit_message }

    begin
      run
    rescue SystemExit=>e
      assert_exit_does_not_abort_commit(e)
    end
  end

  def assert_exit_aborts_commit(e)
    expect(e.status).to eq(1)
  end

  def assert_exit_does_not_abort_commit(e)
    expect(e.status).to eq(0)
  end
end