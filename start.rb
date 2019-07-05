require 'sinatra'
require './demo/back_trade_demo.rb'
require './demo/front_trade_demo.rb'
require './demo/front_trade_demo2.rb'
require './demo/bat_trans.rb'
require './demo/bat_trans_query.rb'
require './demo/file_download.rb'
require './demo/multi_cert_demo.rb'
require './demo/multi_key_demo.rb'
require './demo/encrypt_cer_update_query.rb'
require './demo/front_rcv_response.rb'
require './demo/back_rcv_response.rb'

set :port => 8080

get '/' do
  "<a href='frontTradeDemo'>前台交易示例</a><br>\n" \
  "<a href='frontTradeDemo2'>前台交易示例</a><br>\n"\
  "<a href='backTradeDemo'>后台交易示例</a><br>\n"\
  "<br>\n"\
  "<a href='fileDownload'>对账文件下载示例</a><br>\n"\
  "<a href='batTrans'>批量交易示例</a><br>\n"\
  "<a href='batTransQuery'>批量查询示例</a><br>\n"\
  "<a href='multiCertDemo'>多证书示例</a><br>\n"\
  "<a href='multiKeyDemo'>多密钥示例</a><br>\n"\
  "<a href='encryptCerUpdateQuery'>加密证书更新示例</a><br>\n"
end

get '/frontTradeDemo' do
  FrontTradeDemo.getDemoHtml
end

get '/frontTradeDemo2' do
  FrontTradeDemo2.getDemoHtml
end

get '/backTradeDemo' do
  BackTradeDemo.demoTrade
end

get '/batTrans' do
  BatTrans.demoTrade
end

get '/batTransQuery' do
  BatTransQuery.demoTrade
end

get '/fileDownload' do
  FileDownload.demoTrade
end

get '/multiCertDemo' do
  MultiCertDemo.demoTrade
end

get '/multiKeyDemo' do
  MultiKeyDemo.demoTrade
end

get '/encryptCerUpdateQuery' do
  EncryptCerUpdateQuery.demoTrade
end

post '/frontRcvResponse' do
  FrontRcvResponse.notify(params)
end

post '/backRcvResponse' do
  BackRcvResponse.notify(params)
end
