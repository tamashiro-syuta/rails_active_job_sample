class AsyncLogJob < ApplicationJob
  queue_as :default

  # 非同期処理時に呼ばれる
  def perform(message: 'hello')
    # DBに保存
    AsyncLog.create!(message: message)
  end
end
