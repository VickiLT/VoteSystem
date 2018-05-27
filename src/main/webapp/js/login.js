/**
 * Created by luter on 2018-5-26-0026.
 */
function forgetPw(){
    layui.use(['layer'], function () {
        var layer = layui.layer;
        layer.open({
            type: 2,
            area: ['400px', '360px'],
            shadeClose: true, //点击遮罩关闭
            skin: 'layui-layer-rim',
            closeBtn: 1,
            content: '/manage/managerManage/addConsoleDlg',
            success: function (layero, index) {
                var body = layer.getChildFrame('body', index);
                var s = body.contents().find("#id");
                body.contents().val("用户名");
                body.contents().val("邮箱");
                body.contents().val("身份");

                //body.contents().find("#id").attr("readOnly", "true");
            },
            btn: ['取消', '确定'],
            btn2: function (index, layero) {
                //按钮【按钮2】的回调
                editItem(index, layero);
                return false;
            }
        })
    })
}