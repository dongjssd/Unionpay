#encoding: utf-8
require File.dirname(__FILE__) + "/demo_base.rb"

# 包含样例：签名、加密、后台post、验签、解customerInfo

# 以下样例使用的接口为无跳转产品的开通状态查询接口，后台类接口可以根据此demo修改代码，注意url参数也请根据不同接口替换
# 不同的值，具体参数如何填写请尽量参考其他语言开发包demo文件夹下的示例和注释说明。

class FrontRcvResponse < DemoBase

  def FrontRcvResponse.notify(params)
    Com::UnionPay::Acp::Sdk::LogUtil.info("notify req:[" + reqStr(params) + "]")
    result = "收到通知：" + reqStr(params) + "<br>\n"
    if(Com::UnionPay::Acp::Sdk::AcpService.validate(params))  #服务器签名验证成功
        #请在这里加上商户的业务逻辑程序代码
        #获取通知返回参数，可参考接口文档中通知参数列表(以下仅供参考)
        respCode = params["respCode"] # 交易状态
      if respCode == "00" or respCode == "A6"
          #判断respCode=00、A6后，对涉及资金类的交易，请再发起查询接口查询，确定交易成功后更新数据库。
          return result + "成功"
      else
          return result + "fail"
      end
    else  # 服务器签名验证失败
      return result + "验签失败"
    end
  end
end

def reqStr(params)
    result = ""
  for key in params.keys
    result = result + key + "=" + params[key] + ", "
  end
  result = result[0, result.length]
  return result
end