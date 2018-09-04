require 'rails_helper'

describe MovieExporterJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  before do
    @user = FactoryBot.create(:user)
  end

  subject(:job) {described_class.perform_later(@user)}

  it 'queues the job' do
    expect {job}.to have_enqueued_job(MovieExporterJob)
  end

end
