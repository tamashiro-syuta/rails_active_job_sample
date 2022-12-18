class AsyncLogJob < ApplicationJob
  # async_logというキューにジョブを追加するように設定
  queue_as :async_log

  # 非同期処理時に呼ばれる
  def perform(message: 'hello')
    # DBに保存
    AsyncLog.create!(message: message)
  end
end
