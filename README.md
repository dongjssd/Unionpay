# Unionpay
银联支付 ruby实现 参考代码

> 引用银联支付开发包：https://open.unionpay.com/ajweb/help/faq/list?id=38&level=0&from=0&keyword=%E7%AD%BE%E5%90%8D%E7%AE%97%E6%B3%95%E4%B8%8E%E6%B3%A8%E6%84%8F%E7%82%B9

ruby2.3.0环境调试

ruby2.3.0环境调试

sdk的依赖包:
gem install jruby-openssl -V
gem install iniparse -V
demo用到的依赖包：
gem install sinatra -V
gem install rubyzip -V

目录结构

upacp_sdk_ruby
  │
  ├com.unionpay.acp.sdk ┈┈┈┈┈┈┈┈┈ sdk，其中AcpService为对外接口，其他为内部使用
  │  │
  │  └acp_sdk.ini ┈┈┈┈┈┈┈┈┈ 配置文件，默认使用了测试环境证书方式签名的配置文件
  │
  ├demo
  │  │
  │  ├backRcvResponse.rb ┈┈┈┈┈┈┈┈┈ 后台通知演示
  │  │
  │  ├frontRcvResponse.rb ┈┈┈┈┈┈┈┈┈ 前台通知演示
  │  │
  │  ├batTrans.rb ┈┈┈┈┈┈┈┈┈ 批量交易演示
  │  │
  │  ├batTransQuery.rb ┈┈┈┈┈┈┈┈┈ 批量查询演示
  │  │
  │  ├fileDownload.rb ┈┈┈┈┈┈┈┈┈ 对账文件下载演示
  │  │
  │  ├multiCertDemo.rb ┈┈┈┈┈┈┈┈┈ 多证书签名演示
  │  │
  │  ├multiKeyDemo.rb ┈┈┈┈┈┈┈┈┈ 多密钥签名演示
  │  │
  │  ├backTradeDemo.rb ┈┈┈┈┈┈┈┈┈ 后台交易演示*
  │  │
  │  ├frontTradeDemo.rb ┈┈┈┈┈┈┈┈┈ 前台交易演示*
  │  │
  │  └frontTradeDemo2.rb ┈┈┈┈┈┈┈┈┈ 前台交易演示*
  │
  └start.rb ┈┈┈┈┈┈┈┈┈ demo的web服务启动


demo说明：
*   默认8080端口启动，启动后浏览器访问http://ip:8080/
*   具体接口字段请参考其他语言开发包demo文件夹下的demo代码。
    eg.
    如果demo里使用了AcpService.createAutoFormHtml，则参考frontTradeDemo代码修改。
    如果demo里使用了AcpService.post，则参考backTradeDemo代码修改。

生产、测试环境证书、配置文件、样例对账文件、样例批量文件等参考其他语言开发包assets文件夹。
注意涉及加密的业务上规定只能用证书方式签名，请勿使用密钥方式签名的配置文件。
其他说明请参考其他语言开发包的readme。


history
2017/2/8
验证验签证书的方法改为证书链验证，如果旧开发包更新的话注意配置文件需要多加root证书。



