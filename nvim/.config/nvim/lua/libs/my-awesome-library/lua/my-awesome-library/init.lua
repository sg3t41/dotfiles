-- ライブラリの本体となるテーブルを作成
local M = {}

-- 'hello' という名前の関数を定義
function M.hello()
  print("Hello from my awesome library!")
end

-- このテーブルを返すことで、他のファイルから require できるようになる
return M