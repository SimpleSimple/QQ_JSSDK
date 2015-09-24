<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="QQConnection.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta property="qc:admins" content="350172761453112167636" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="101237453" data-redirecturi="http://www.99ducaijing.com" charset="utf-8"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="pages">
        <span id="qqLoginBtn"></span>
    </div>
    <input type="hidden" id="hidIsLogin" value="-1" />
    </form>
    <!-- 脚本BEGIN -->
    <script src="http://cdn.bootcss.com/jquery/3.0.0-alpha1/jquery.js"></script>
    <script type="text/javascript">

        function fnSignOut(){
            QC.Login.signOut();
            window.location.href = "http://www.99ducaijing.com";
        }

        alert(QC.Login.check());
        (function () {
            //初始化页面加载
            if (window.location.hash.length == 0) {
                QC.Login({
                    btnId: "qqLoginBtn"    //插入按钮的节点id
                });
            } else {

                if (QC.Login.check()) {//如果已登录

                    //这个函数有问题，当QQ授权已登录时，页面重新刷新 QC.Login.check() 依然为true，
                    //但 QC.Login.getMe() 获取不到openId, accessToken
                    //QC.Login.getMe(function (openId, accessToken) {
                    //    alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n"));
                    //});

                    //这里可以调用自己的保存接口
                    //...

                    //从页面收集OpenAPI必要的参数。get_user_info不需要输入参数，因此paras中没有参数
                    var paras = {};

                    //用JS SDK调用OpenAPI
                    QC.api("get_user_info", paras)
                        //指定接口访问成功的接收函数，s为成功返回Response对象
	                    .success(function (s) {
	                        //成功回调，通过s.data获取OpenAPI的返回数据
	                        alert("获取用户信息成功！当前用户昵称为：" + s.data.nickname);
	                    })
                        //指定接口访问失败的接收函数，f为失败返回Response对象
	                    .error(function (f) {
	                        //失败回调
	                        alert("获取用户信息失败！");
	                    })
                        //指定接口完成请求后的接收函数，c为完成请求返回Response对象
	                    .complete(function (c) {
	                        //完成请求回调
	                        alert("获取用户信息完成！");
	                    });

                    var dom = document.getElementById('qqLoginBtn'),
                    _logoutTemplate = [
                    //头像
                    //'<span><img src="{figureurl}" class="{size_key}"/></span>',
                    //昵称
                        '<span>{nickname}</span>',
                    //退出
                        '<span><a href="javascript:fnSignOut();">退出</a></span>'
                    ].join("");
                    dom && (dom.innerHTML = QC.String.format(_logoutTemplate, {
                        nickname: QC.String.escHTML('啊啊啊啊啊啊啊啊啊啊啊，登陆成功！')
                    }));

                    alert(typeof (window.opener));
                    //$("#hidIsLogin").val("1");  //1：登录成功 0：登录失败 -1：未知状态
                    //alert(typeof K);
                    //var isLogined = K.document.getElementById("hidIsLogin").value;
                    //alert(isLogined);

                    if (typeof (window.opener) !== 'undefined') {
                        window.opener.location.href = "http://www.99ducaijing.com";
                    }
                }
            }
        })();
    </script>
</body>
</html>
