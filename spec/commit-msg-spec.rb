begin
  require_relative '../commit-msg'
rescue SystemExit
  # 'rescue' is needed for including the script.  Without it, rspec will exit before the tests are run.
end


describe "commit message script" do
  it "Aborts if branch name starts with branch number, but commit message does not" do
    test_branch_name = "9999_my_branch"
    test_commit_message = "Test commit message"
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

  it "Aborts if branch numbers do not match" do
    test_branch_name = "9999_my_branch"
    test_commit_message = "#1111 - Test commit message"
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
    test_branch_name = "9999_my_branch"
    test_commit_message = "#9999 - Test commit message"
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

  it "Does not abort if branch name does not include branch number (regardless of whether commit message includes number)" do
    test_commit_message = "my message"
    test_branch_name = "master"
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