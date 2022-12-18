require 'test_helper'

class AsyncLogJobTest < ActiveJob::TestCase
  test "Enqueue AsyncLogJob" do
    # assert_enqueued_with アサーションを使ってキューにジョブが追加されているかどうかテスト
    assert_enqueued_with(job: AsyncLogJob) do
      AsyncLogJob.perform_later(message: "form test")
    end
  end
end
