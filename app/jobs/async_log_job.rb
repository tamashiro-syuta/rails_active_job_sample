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

  # エラーをキャッチすると、5秒まってリトライする（3回まで）
  retry_on StandardError, wait: 5.seconds, attempts: 3
  # 複数の例外クラスを指定するパターン
  # retry_on ArgumentError, ZeroDivisionError, wait: 5.seconds, attempts: 3

  # ↑↑↑↑ retry_onの注意点 : sidekiqなどのバックエンド側でリトライの仕組みを持っていないといけない ↑↑↑↑

  # エラーをキャッチしてジョブの破棄
  discard_on ArgumentError

  # ブロックを使う例
  # discard_on StandardError do | job, error |
  #   SomeNotifier.push(error)
  # end

  # 非同期処理時に呼ばれる
  def perform(message: 'hello')
    # DBに保存
    AsyncLog.create!(message: message)
  end
end
