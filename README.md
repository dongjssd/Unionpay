# Unionpay
银联支付 ruby实现 参考代码

> 引用银联支付开发包：https://open.unionpay.com/ajweb/help/faq/list?id=38&level=0&from=0&keyword=%E7%AD%BE%E5%90%8D%E7%AE%97%E6%B3%95%E4%B8%8E%E6%B3%A8%E6%84%8F%E7%82%B9

ruby2.3.0环境调试


sdk的依赖包:
gem install jruby-openssl -V

gem install iniparse -V

demo用到的依赖包：

gem install sinatra -V

gem install rubyzip -V

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



