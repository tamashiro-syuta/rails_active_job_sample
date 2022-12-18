class AsyncLogJob < ApplicationJob
  # async_logというキューにジョブを追加するように設定
  # queue_as :async_log

  # 引数のメッセージで分岐して、キューを選別
  queue_as do
    case self.arguments.first[:message]
    when "to async_log"
      :async_log
    else
      :default
    end
  end

  # 非同期処理時に呼ばれる
  def perform(message: 'hello')
    # DBに保存
    AsyncLog.create!(message: message)
  end
end
